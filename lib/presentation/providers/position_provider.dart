import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nakdong_river/data/repository_firebase.dart';
import 'package:nakdong_river/domain/measurement.dart';

import 'package:nakdong_river/domain/position.dart';

class PositionProvider with ChangeNotifier {
  final RepositoryFirebaseImpl _repository = RepositoryFirebaseImpl();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  PositionProvider(String? code) {
    _position = Position.fromCode(code ?? '2022B1a');
    updateMesure();
  }

  // 좌표
  late Position _position;
  Measurement? _measurement;

  Position get position => _position;
  Measurement? get measurement => _measurement;

  void setPosition(Position position) {
    // 포지션 변경
    _position = position;
    storage.write(key: 'position', value: position.code);

    // 측정값 변경
    updateMesure();
    notifyListeners();
  }

  void updateMesure() async {
    List<Measurement> dateList = await _repository.getRecentData(_position);
    _measurement = null;
    if (dateList.isNotEmpty) {
      // 수온 평균
      var salinity = dateList.map((e) => e.salinity).reduce((a, b) => a + b) /
          dateList.length;
      // 염도 평균
      var temperature =
          dateList.map((e) => e.temperature).reduce((a, b) => a + b) /
              dateList.length;
      // 수심 평균
      var depth = dateList.map((e) => e.depth).reduce((a, b) => a + b) /
          dateList.length;

      _measurement = Measurement(
        date: dateList.first.date,
        depth: depth,
        salinity: salinity,
        temperature: temperature,
        location: dateList.first.location,
        locationCode: dateList.first.locationCode,
      );
    }
    notifyListeners();
  }
}
