import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tflite/tflite.dart';

import '../constants/constants.dart';

class TfliteModel extends StatefulWidget {
  static const String routeName = '/tflite-model';

  @override
  _TfliteModelState createState() => _TfliteModelState();
}

class _TfliteModelState extends State<TfliteModel> {
  late File _image;
  bool imageSelect = false;
  bool isLoading = false;
  late String imageURL;
  late String label = '';

  @override
  void initState() {
    super.initState();
    loadModel();
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
    Map<String, String> results = await imageClassification(image);
    setState(() {
      label = 'Plant: ${results['plant']}\nDisease: ${results['disease']}';
      isLoading = false;
    });
  }

  Future loadModel() async {
    String res;
    res = (await Tflite.loadModel(
        model: "assets/model/SequentialModel_v3.tflite",
        labels: "assets/model/labels.txt"))!;
    if (kDebugMode) {
      print("Models loading status: $res");
    }
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  Future<void> saveImage(File imageFile, List<String> labelParts) async {
    final imageName =
        '${labelParts[0]}_${labelParts[1]}____${DateTime.now().millisecondsSinceEpoch}.png';
    final externalDirectory = await getExternalStorageDirectory();
    final publicImagePath = '${externalDirectory?.path}/$imageName';
    await imageFile.copy(publicImagePath);
    if (kDebugMode) {
      print('Public image saved at $publicImagePath');
    }
  }

  Future<Map<String, String>> imageClassification(File image) async {
    final List? recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 15,
      threshold: 0.1,
      imageMean: 0.0,
      imageStd: 255.0,
    );

    final String label = recognitions![0]['label'];

    final List<String> labelParts = label.split(" ");
    final String plant = labelParts[0];
    String disease = "no disease";
    if (labelParts.length > 1) {
      disease = labelParts[1];
    }
    if (kDebugMode) {
      print('Plant: $plant, Disease: $disease');
    }

    await saveImage(image, labelParts);

    setState(() {
      _image = image;
      imageSelect = true;
      isLoading = false;
    });

    return {'plant': plant, 'disease': disease};
  }

  Widget customButton(String textOnButton, ImageSource source) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
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
      backgroundColor: onPrimaryColor,
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
                    child: Image.file(
                      _image,
                      fit: BoxFit.cover,
                      width: height * 0.4,
                      height: width * 0.9,
                    ),
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
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: textColor2,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            customButton("Pick Image from Gallery", ImageSource.gallery),
            const SizedBox(height: 10),
            customButton("Pick Image from Camera", ImageSource.camera),
          ],
        ),
      ),
    );
  }
}
