import 'package:nakdong_river/domain/measurement.dart';
import 'package:nakdong_river/domain/position.dart';

abstract class MeasurementRepository {
  /// 저장되어 있는 데이터 중 가장 최근의 10개의 데이터를 반환한다.
  Future<List<Measurement>> getRecentData(Position position);
}
