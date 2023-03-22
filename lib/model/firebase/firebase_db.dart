import 'package:firebase_database/firebase_database.dart';

class FireBaseDataBaseModel {
  late String plant;
  late String disease;
  late String downloadURL;
  FireBaseDataBaseModel(
      {required this.plant, required this.disease, required this.downloadURL});

  late DatabaseReference databaseReference;

  Future<void> uploadDocument() async {
    databaseReference = FirebaseDatabase.instance.ref().child('plants').push();

    await databaseReference.set({
      'plant_name': plant,
      'disease': disease,
      'image_url': downloadURL,
    });
  }

  Future<Map<String, dynamic>> getDataBaseData() async {
    DataSnapshot snapshot = (await databaseReference.once()) as DataSnapshot;
    Map<String, dynamic> patients = snapshot.value as Map<String, dynamic>;
    return patients;
  }
}
