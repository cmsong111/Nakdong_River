import 'package:http/http.dart' as http;
import 'package:nakdong_river/main.dart';
import 'package:nakdong_river/model.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

var queryParameters = {
  'ServiceKey':
      "P85FKUFu2kJIbADd5Sf2NMcuhK9sGMcciPLj3s0tm%2BtOG9SBwS0Dk6t5dkUnl0Un7EA%2F5TzGsbI%2F2fV%2BcmA4%2FQ%3D%3D",
  'sDate': getToday(),
  'sTime': beforeTime(),
  'eTime': afterTime(),
  'wtqltObsrvtCd': '2022B1a',
  'numOfRows': '1',
  'pageNo': '1',
  '_type': 'json',
};

Future<Temp> getTemp() async {
  final response = await http.get(
    Uri.http("opendata.kwater.or.kr",
        "/openapi-data/service/pubd/wroWaterSaln/list", queryParameters),
  );
  teststring = response.body.toString();

  if (response.statusCode == 200) {
    return Temp.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load userinfo');
  }
}

String getToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyyMMdd');
  String strToday = formatter.format(now);
  return strToday;
}

String beforeTime() {
  DateTime now = DateTime.now();
  now = now.add(const Duration(minutes: -20));

  DateFormat formatter = DateFormat('HHmm');
  String time = formatter.format(now);
  return "${time.substring(0, 3)}0";
}

String afterTime() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('HHmm');
  String time = formatter.format(now);
  int temp = int.parse(time.substring(2, 3));

  return "${time.substring(0, 2)}${temp + 1}0";
}
