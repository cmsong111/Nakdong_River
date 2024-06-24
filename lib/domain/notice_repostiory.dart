import 'package:nakdong_river/domain/notice.dart';

abstract class NoticeRepository {
  Future<List<Notice>> getRecentData();
}
