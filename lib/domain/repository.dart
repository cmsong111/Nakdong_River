import 'package:nakdong_river/domain/measurement.dart';
import 'package:nakdong_river/domain/position.dart';

abstract class Repository {
  /// 포지션에 해당하는 측정 깊이 리스트를 반환한다.
  Future<List<String>> getDepths(Position position);

  /// 포지션에 해당하는 측정 데이터 리스트를 반환한다.
  Future<List<Measurement>> getMeasurements(Position position, String depth);
}
