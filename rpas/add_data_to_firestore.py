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

# 계측 종료 일자 HHMM (ex: 1000, max:2400)
eTime = now.strftime("%H%M")

# 일자가 다른 경우 API 호출이 불가능하므로 now를 2400으로 변경
if now.date() != start.date():
    eTime = "2400"

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


def upload_data(item: dict):
    """데이터를 파이어베이스에 업로드하는 함수"""
    try:
        # 필요한 데이터만 추출
        kst = pytz.timezone('Asia/Seoul')
        msmtTm = datetime.datetime.strptime(
            str(item['msmtTm']), '%Y%m%d%H%M')
        doc_id_depth = str(item['altdDpwt'])
        mesure_date = msmtTm.strftime('%Y-%m-%d')
        mesure_time = msmtTm.strftime('%H:%M')
        item['msmtTm'] = datetime.datetime.strptime(
            str(item['msmtTm']), '%Y%m%d%H%M')
        item['msmtTm'] = kst.localize(msmtTm)

        # 필요없는 데이터 삭제
        del item['mesureDpwt']
        del item['altdDpwt']
        del item['ec']
        del item['wtqltObsrvtCd']
        del item['obsrvtNm']

        # 수치 데이터 형변환(숫자 -> 문자 (,제거) -> 숫자)
        if type(item['saln']) == str:
            item['saln'] = item['saln'].replace(',', '')
        item['saln'] = float(item['saln'])

        if type(item['wtep']) == str:
            item['wtep'] = item['wtep'].replace(',', '')
        item['wtep'] = float(item['wtep'])

        # 파이어베이스 Empty Collection 생성(검사가 안되는 문제 해결)
        if db.collection(wtqltObsrvtCd[key]).document(doc_id_depth).get().exists is False:
            db.collection(wtqltObsrvtCd[key]).document(
                doc_id_depth).set({})

        # 파이어베이스 데이터 업로드
        db.collection(wtqltObsrvtCd[key]).document(
            doc_id_depth).collection(mesure_date).document(mesure_time).set(item)

    except Exception as e:
        print("Error: ", e)


# 염분 수질관측소 코드별로 반복문 실행
for key in wtqltObsrvtCd:

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

    count = 1
    while True:
        try:
            response = requests.get(url=END_POINT, params=parameters)
            print("First Response Code: ", response.status_code)

        except Exception as e:
            print("Error: ", e)
            break

        if response.status_code == 200:
            response = json.loads(response.text)

            print("Response:", response['response']['header'])
            print("data Length: ", response['response']['body']['totalCount'])

            if response['response']['body']['totalCount'] == 0:
                print("No data")
            elif response['response']['body']['totalCount'] == 1:
                print("One data")
                upload_data(response['response']['body']['items']['item'])
            else:
                print("Many data")
                for data in response['response']['body']['items']['item']:
                    upload_data(data)

            print("Data Upload Success at", wtqltObsrvtCd[key], "\n\n")
            break

        print("Error occurred. Retry Count: ", count)
        count += 1
        time.sleep(1)

        if count > 100:
            print("Retry Count Over 100")
            break
