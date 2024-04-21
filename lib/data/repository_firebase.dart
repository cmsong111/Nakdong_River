import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:nakdong_river/domain/measurement.dart';
import 'package:nakdong_river/domain/position.dart';
import 'package:nakdong_river/domain/repository.dart';

class RepositoryFirebaseImpl extends Repository {
  static FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  Future<List<String>> getDepths(Position position) async {
    var response = await instance.collection(position.code).get();
    return response.docs.map((e) => e.id).toList();
  }

  @override
  Future<List<Measurement>> getRecentData(
      Position position, String depth) async {
    final today = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(today);
    List<Measurement> dateList = [];

    var response = await instance
        .collection(position.code)
        .doc(depth)
        .collection(formattedDate)
        .orderBy('msmtTm', descending: true)
        .limit(10)
        .get();

    for (final doc in response.docs) {
      dateList.add(Measurement.fromFireStore(doc.data(), position, depth));
    }

    if (response.docs.length < 10) {
      formattedDate = DateFormat('yyyy-MM-dd')
          .format(today.subtract(const Duration(days: 1)));
      response = await instance
          .collection(position.code)
          .doc(depth)
          .collection(formattedDate)
          .orderBy('msmtTm', descending: true)
          .limit(10 - response.docs.length)
          .get();

      for (final doc in response.docs) {
        dateList.add(Measurement.fromFireStore(doc.data(), position, depth));
      }
    }
    return dateList;
  }
}
