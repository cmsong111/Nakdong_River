import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nakdong_river/domain/notice.dart';
import 'package:nakdong_river/domain/notice_repostiory.dart';

class NoticeRepositoryFirebase implements NoticeRepository {
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  Future<List<Notice>> getRecentData() {
    return instance
        .collection("notice")
        .orderBy("createdAt", descending: true)
        .get()
        .then((value) =>
            value.docs.map((e) => Notice.fromMap(e.data())).toList());
  }
}
