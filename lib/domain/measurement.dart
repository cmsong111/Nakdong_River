import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nakdong_river/domain/position.dart';

/// 측정 데이터 모델
class Measurement {
  final Position position;
  final String depth;
  final Timestamp time;
  final num salinity;
  final num temperature;

  const Measurement({
    required this.depth,
    required this.time,
    required this.position,
    required this.salinity,
    required this.temperature,
  });

  /// FireStore에서 받아온 데이터를 Measurement로 변환한다.
  static Measurement fromFireStore(
      Map<String, dynamic> json, Position position, String depth) {
    return Measurement(
      depth: depth,
      position: position,
      time: json['msmtTm'],
      salinity: json['saln'],
      temperature: json['wtep'],
    );
  }

  @override
  String toString() {
    return 'Measurement{position: ${position.name}, depth: $depth, time: ${time.toDate().toString()}, salinity: $salinity, temperature: $temperature}';
  }
}
