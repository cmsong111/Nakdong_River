import 'package:cloud_firestore/cloud_firestore.dart';

/// 측정 데이터 모델
class Measurement {
  final Timestamp date;
  final num depth;
  final String location;
  final String locationCode;
  final double salinity;
  final double temperature;

  Measurement({
    required this.date,
    required this.depth,
    required this.location,
    required this.locationCode,
    required this.salinity,
    required this.temperature,
  });

  factory Measurement.fromMap(Map<String, dynamic> map) {
    return Measurement(
      date: map['mesure_date'],
      depth: map['mesure_depths'],
      location: map['mesure_location'],
      locationCode: map['mesure_location_code'],
      salinity: map['mesure_salinity'],
      temperature: map['mesure_temperature'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mesure_date': date,
      'mesure_depths': depth,
      'mesure_location': location,
      'mesure_location_code': locationCode,
      'mesure_salinity': salinity,
      'mesure_temperature': temperature,
    };
  }

  @override
  String toString() {
    return 'Measurement{date: $date, depth: $depth, location: $location, locationCode: $locationCode, salinity: $salinity, temperature: $temperature}';
  }
}
