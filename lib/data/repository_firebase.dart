import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nakdong_river/domain/measurement.dart';
import 'package:nakdong_river/domain/position.dart';
import 'package:nakdong_river/domain/measurement_repository.dart';

class RepositoryFirebaseImpl extends MeasurementRepository {
  static FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  Future<List<Measurement>> getRecentData(Position position) async {
    List<Measurement> dateList = [];

    var response = await instance
        .collectionGroup("data")
        .where("mesure_location_code", isEqualTo: position.code)
        .where("mesure_salinity", isNotEqualTo: 0)
        .orderBy("mesure_date", descending: true)
        .limit(10)
        .get();

    for (final doc in response.docs) {
      dateList.add(Measurement.fromMap(doc.data()));
    }

    return dateList;
  }
}
