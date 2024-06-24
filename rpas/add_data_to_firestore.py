import sys
import requests
import datetime
import pytz
import os
import time
import json

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Firebase FireStore 초기화
cred = credentials.Certificate("serviceAccount.json")
firebase_admin.initialize_app(cred)
db = firestore.client()


# 환경변수 설정
END_POINT = os.environ['END_POINT']
SERVICE_KEY = os.environ['SERVICE_KEY']

# 현재 시간 (End-time)
now = datetime.datetime.now(tz=pytz.timezone('Asia/Seoul'))

# 시작 시간(Start-time, 현재시간 - 15분)
start = now - datetime.timedelta(minutes=15)

# 계측일자 YYYYMMDD (ex: 20240101)
sDate = start.strftime("%Y%m%d")

# 계측시간 HHMM (ex: 0000)
sTime = start.strftime("%H%M")
if start.date() != now.date():
    sTime = "0000"

# 계측 종료 일자 HHMM (ex: 1000, max:2400)
eTime = now.strftime("%H%M")

# 염분 수질관측소 코드
wtqltObsrvtCd = {
    '하구둑8번교각': "2022B4a",
    '하구둑10번교각': "2022B4b",
    '갑문상류': "2022B4c",
    '을숙도대교P3': "2022B5a",
    '을숙도대교P20': "2022B5b",
    '낙동강 하구둑': "2022B1a",
    '낙동대교': "2022B2a",
    '우안배수문': "2022B3a",
    '낙동강상류3km': "2022A1a",
    '낙동강상류7.5km': "2022A1b",
    '낙동강상류9km': "2022A2b",
    '낙동강상류10km': "2022A2a"
}

# 한 페이지 결과 수 ()
numOfRows = 100

# 페이지 번호
pageNo = 1

# 데이터 포맷 (json, xml)
_type = "json"


def str_to_float(s: str) -> float:
    """문자열을 실수로 변환하는 함수"""
    return float(s.replace(',', ''))


def upload_data_to_firestore(item: dict):
    """데이터를 파이어베이스에 업로드하는 함수"""

    # 측정 위치
    mesure_location: str = item['obsrvtNm']
    mesure_location_code: str = item['wtqltObsrvtCd']

    # 측정 시간(계측일자 + 계측시간, KST)
    mesure_date: datetime = pytz.timezone(
        'Asia/Seoul').localize(datetime.datetime.strptime(str(item['msmtTm']), '%Y%m%d%H%M'))

    # 측정 수심)
    mesure_depths: float = item['altdDpwt']
    if type(mesure_depths) == str:
        mesure_depths: float = str_to_float(mesure_depths)

    # 측정 염분
    mesure_salinity: float = item['saln']
    if type(mesure_salinity) == str:
        mesure_salinity: float = str_to_float(mesure_salinity)

    # 측정 수온
    mesure_temperature: float = item['wtep']
    if type(mesure_temperature) == str:
        mesure_temperature: float = str_to_float(mesure_temperature)

    # 파이어베이스 DB 초기화(염분 수질관측소 코드별로)(염분 수질관측소 코드가 없는 경우 생성)
    point_collection = db.collection("data")

    # 파이어베이스 데이터 업로드
    point_collection.add({
        'mesure_date': mesure_date,
        'mesure_location': mesure_location,
        'mesure_location_code': mesure_location_code,
        'mesure_depths': mesure_depths,
        'mesure_salinity': mesure_salinity,
        'mesure_temperature': mesure_temperature
    })


# 염분 수질관측소 코드별로 반복문 실행
for key in wtqltObsrvtCd:

    # 파라미터 설정
    print(key, wtqltObsrvtCd[key])
    parameters = {
        'serviceKey': SERVICE_KEY,
        'sDate': sDate,
        'sTime': sTime,
        'eTime': eTime,
        'wtqltObsrvtCd': wtqltObsrvtCd[key],
        'numOfRows': numOfRows,
        'pageNo': pageNo,
        '_type': _type
    }
    print("parameters: ", parameters)

    # API 호출
    count = 1
    while True:
        try:
            response = requests.get(url=END_POINT, params=parameters)
            print("Response Code: ", response.status_code)
        except Exception as e:
            print("Error occurred. Retry Count: ", count)
            print("Error: ", e)

        if response.status_code == 200:
            break

        time.sleep(1)

    # API 응답 데이터 처리
    response = json.loads(response.text)

    print("Response:", response['response']['header'])
    print("data Length: ", response['response']['body']['totalCount'])

    if response['response']['body']['totalCount'] == 0:
        print("No data")
    elif response['response']['body']['totalCount'] == 1:
        print("One data")
        upload_data_to_firestore(response['response']['body']['items']['item'])
    else:
        print("Many data")
        for data in response['response']['body']['items']['item']:
            upload_data_to_firestore(data)

    print("Data Upload Success at", wtqltObsrvtCd[key], "\n\n")
