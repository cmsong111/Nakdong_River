import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<List<Measurement>> getMeasurements(
      Position position, String depth) async {
    final snapshot = await instance
        .collection(position.code)
        .doc(depth)
        .collection('data')
        .get();

    List<Measurement> measurements = [];

    for (final doc in snapshot.docs) {
      measurements.add(Measurement.fromFireStore(
          doc.data() as Map<String, dynamic>, position, depth));
      print(doc.data());
    }

    return measurements;
  }
}
