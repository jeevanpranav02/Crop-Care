import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:crop_capture/pages/constants.dart';

class TfliteModel extends StatefulWidget {
  const TfliteModel({Key? key}) : super(key: key);
  static const String routeName = '/tflite-model';

  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
  late File _image;
  late List _results;
  bool imageSelect = false;
  bool isLoading = false;
  late String imageURL;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    String res;
    res = (await Tflite.loadModel(
        model: "assets/model/denseNetModel.tflite",
        labels: "assets/model/labels.txt"))!;
    print("Models loading status: $res");
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  Future<String> saveImage(File imageFile, String label) async {
    final directory = await getApplicationDocumentsDirectory();
    final imageName = "${DateTime.now().millisecondsSinceEpoch}_$label.png";
    final imagePath = '${directory.path}/$imageName';
    print('Image saved at $imagePath');
    return imagePath;
  }

  Future imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 4,
      threshold: 0.1,
      imageStd: 1,
    );

    // Saving the image captured with label as name to store it in DB
    final String label = recognitions![0]['label'];
    final String imagePath = await saveImage(image, label);

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    // Create a reference for the image to be stored
    Reference referenceImageToUpload = referenceDirImages
        .child('${DateTime.now().millisecondsSinceEpoch}_$label.png');

    // Now upload the file in storage.
    try {
      await referenceImageToUpload.putFile(image);
      imageURL = await referenceImageToUpload.getDownloadURL();
    } on Exception catch (e) {
      e.toString();
    }

    setState(() {
      _results = recognitions;
      _image = File(imagePath);
      imageSelect = true;
      isLoading = false;
    });
  }

  Widget customButton(String textOnButton, ImageSource source) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(fontSize: 16),
        ),
      ),
      child: Text(
        textOnButton,
        style: const TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        pickImage(source);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            (imageSelect)
                ? Container(
                    margin: const EdgeInsets.all(10),
                    constraints: BoxConstraints(
                      maxWidth: height * 0.4,
                      maxHeight: width * 0.9,
                    ),
                    child: Image.file(_image),
                  )
                : Container(
                    margin: const EdgeInsets.all(10),
                    child: const Opacity(
                      opacity: 0.8,
                      child: Center(
                        child: Text("No image selected"),
                      ),
                    ),
                  ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              child: Column(
                children: (imageSelect)
                    ? _results.map((result) {
                        return Card(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Text(
                              "${result['label']}",
                              style: const TextStyle(
                                color: textColor2,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      }).toList()
                    : [if (isLoading) const CircularProgressIndicator()],
              ),
            ),
            customButton("Pick Image from Gallery", ImageSource.gallery),
            const SizedBox(height: 10),
            customButton("Pick Image from Camera", ImageSource.camera),
          ],
        ),
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: source,
    );
    setState(() {
      isLoading = true;
      imageSelect = false;
    });
    File image = File(pickedFile!.path);
    imageClassification(image);
  }
}
