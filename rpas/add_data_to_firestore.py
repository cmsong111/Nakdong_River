import sys
import requests
import datetime
import pytz
import os
import time

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Upload Data to Firebase
cred = credentials.Certificate("serviceAccount.json")
firebase_admin.initialize_app(cred)
db = firestore.client()


# API: 한국수자원공사_낙동강 하구 염분
END_POINT = os.environ['END_POINT']
SERVICE_KEY = os.environ['SERVICE_KEY']

# 현재 시간
now = datetime.datetime.now(tz=pytz.timezone('Asia/Seoul'))

# 현재 시간을 기준으로 계측일자를 설정
# 게측 일자는 현재 기준 -1시간으로 설정 (현재 시간이 00시 이전이면 전날로 설정) (분은 00시로 설정)
if now.hour == 0:
    now = now.replace(hour=23, minute=0, second=0, microsecond=0)
    now = now - datetime.timedelta(days=1)
else:
    now = now.replace(hour=now.hour-1, minute=0, second=0, microsecond=0)

print("현재 시간: ", now)


# 계측 시간은 1시간 이후로
until = now + datetime.timedelta(hours=1)
print("계측 종료 시간: ", until)


# 계측일자 YYYYMMDD
sDate = now.strftime("%Y%m%d")

# 계측시간 HHMM
sTime = now.strftime("%H%M")

# 계측 종료 일자 HHMM
eTime = until.strftime("%H%M")

if sTime == "2300":
    eTime = "2359"

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

    data = requests.get(url=END_POINT, params=parameters).json()

    # 데이터가 없을 경우
    if data['response']['body']['totalCount'] == 0:
        print("No Data")
        continue

    for item in data['response']['body']['items']['item']:
        # 필요한 데이터만 추출
        kst = pytz.timezone('Asia/Seoul')
        msmtTm = datetime.datetime.strptime(str(item['msmtTm']), '%Y%m%d%H%M')
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
            db.collection(wtqltObsrvtCd[key]).document(doc_id_depth).set({})

        # 파이어베이스 데이터 업로드
        db.collection(wtqltObsrvtCd[key]).document(
            doc_id_depth).collection(mesure_date).document(mesure_time).set(item)

    time.sleep(30)
