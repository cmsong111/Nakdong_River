import 'package:nakdong_river/domain/measurement.dart';
import 'package:nakdong_river/domain/position.dart';

abstract class Repository {
  /// 포지션에 해당하는 측정 깊이 리스트를 반환한다.
  Future<List<String>> getDepths(Position position);

  /// 저장되어 있는 데이터 중 가장 최근의 10개의 데이터를 반환한다.
  Future<List<Measurement>> getRecentData(Position position, String depth);

  /// 저장되어 있는 데이터 중 가장 최근의 1개의 데이터를 반환한다.
  Future<Measurement> getRecentDataOne(Position position, String depth);
}
