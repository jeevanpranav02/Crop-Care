import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireBaseStorageModel {
  final File image;
  final String label;
  late String imageURL;
  FireBaseStorageModel({required this.image, required this.label});

  Future<void> uploadImageToStorage() async {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    // Create a reference for the image to be stored
    Reference referenceImageToUpload = referenceDirImages
        .child('${DateTime.now().millisecondsSinceEpoch}-$label-disease.png');

    // Now upload the file in storage.
    try {
      await referenceImageToUpload.putFile(image);
      imageURL = await referenceImageToUpload.getDownloadURL();
    } on Exception catch (e) {
      e.toString();
    }
  }

  Future<String> getImageURL() async {
    return imageURL;
  }
}
