<img  style=" 
height : 300px;
border-radius: 7px;
-moz-border-radius: 7px;
-khtml-border-radius: 7px;
-webkit-border-radius: 7px;
" src="https://user-images.githubusercontent.com/23499675/188171201-fc124ac6-4e3b-41e4-81c7-d5f636c55df8.png" align="left"/> 

<!-- <br>
&nbsp;&nbsp;<font size=6> 낙동 - 낭동강 수온측정 </font>
<br>
&nbsp;&nbsp;<font size=5> Namju </font>

<br>
&nbsp;&nbsp;&nbsp; <font size=2> Downloaed 1+ </font> -->
<img src="https://user-images.githubusercontent.com/23499675/188191826-8bb00de7-4173-4be4-8bee-01570da46473.JPG"  width="63%" />


<a href='https://play.google.com/store/apps/details?id=com.namju.nakdong_river&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img width="30%" alt='다운로드하기 Google Play' src='https://play.google.com/intl/ko/badges/static/images/badges/ko_badge_web_generic.png'/></a>

<br>
<br>
<br>
<br>

## ScreenShot
<img src="https://user-images.githubusercontent.com/23499675/188184496-824a7c6e-bf13-40f5-a55d-63de85456693.jpg"  width="30%" />&nbsp;&nbsp;<img src="https://user-images.githubusercontent.com/23499675/188184505-8092211e-58aa-4456-89ed-8a206114c05f.jpg"  width="30%" />&nbsp;&nbsp; <img src="https://user-images.githubusercontent.com/23499675/188184468-899f3974-6fa8-4632-a717-e62e2b62c50a.jpg"  width="30%" />

## How to build APP

* Way 1
    1. <a herf="https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15081180">Download from google playstore</a>
* Way 2
    1. clone project
        ```
        gh repo clone cmsong111/Nakdong_River
         ```
    2. Publish API Key from data.go.kr 
    <br><a herf="https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15081180">공공데이터 포털 - 한국수자원공사_낙동강 하구 염분</a>

    3. Create .env file at Nakdong_River/ and wirte your API key
        ```
        ServiceKey = <input Your key>
        ```
    4. typing CLI
        ```
        flutter run -- realese
        ```

* You can Also build IOS APP

# Update note
   
## ver 1.0
### Add 8 Point
- 하구둑8번교각<br>
- 하구둑10번교각<br>
- 갑문상류<br>
- 을숙도대교P3<br>
- 을숙도대교P20<br>
- 낙동강 하구둑<br>
- 낙동대교<br>
- 우안배수문<br>