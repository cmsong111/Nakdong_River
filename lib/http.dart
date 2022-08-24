import 'package:http/http.dart' as http;
import 'package:nakdong_river/main.dart';
import 'package:nakdong_river/model.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var queryParameters = {
  'ServiceKey': dotenv.env['ServiceKey'],
  'sDate': getToday(),
  'sTime': beforeTime(),
  'eTime': afterTime(),
  'wtqltObsrvtCd': '2022B2a',
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
  now = now.add(const Duration(minutes: -20));
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
