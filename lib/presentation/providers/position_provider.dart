import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nakdong_river/data/repository_firebase.dart';
import 'package:nakdong_river/domain/measurement.dart';
import 'package:nakdong_river/domain/position.dart';
import 'package:nakdong_river/domain/repository.dart';

class PositionProvider with ChangeNotifier {
  final Repository _repository = RepositoryFirebaseImpl();

  PositionProvider(Position position) {
    setPosition(position);
    updateDepths();
  }

  // 좌표
  Position _position = Position.point1;

  Position get position => _position;

  void setPosition(Position position) {
    _position = position;
    updateDepths();
    notifyListeners();
  }

  // 측정 깊이
  List<String> _depths = ["0"];

  List<String> get depths => _depths;

  int get depthsLength => _depths.length;

  void updateDepths() async {
    _depths = await _repository.getDepths(_position);
    _depths.sort((a, b) => double.parse(a).compareTo(double.parse(b)));
    setCurrentSliderValue(0.0);
    updateMeasureData(_depths[0]);
    notifyListeners();
  }

  // 슬라이더 값
  int _currentSliderValue = 0;

  int get currentSliderValue => _currentSliderValue;

  String get currnetDepthLabel => "수심 ${_depths[_currentSliderValue.toInt()]}m";

  void setCurrentSliderValue(double value) {
    _currentSliderValue = value.toInt();
    updateMeasureData(_depths[_currentSliderValue]);
    notifyListeners();
  }

  // 측정 데이터
  Measurement _measurements = Measurement(
    depth: "0",
    time: Timestamp.now(),
    position: Position.point1,
    salinity: 0,
    temperature: 0,
  );

  Measurement get measurements => _measurements;

  void updateMeasureData(String depth) async {
    _measurements = await _repository.getRecentDataOne(_position, depth);
    notifyListeners();
  }
}
