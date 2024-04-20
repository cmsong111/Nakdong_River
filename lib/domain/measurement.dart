/// 측정 데이터 모델
class Measurement {
  final double depth;
  final DateTime time;
  final String point;
  final double salinity;
  final double temperature;

  const Measurement({
    required this.depth,
    required this.time,
    required this.point,
    required this.salinity,
    required this.temperature,
  });
}
