import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import 'widgets/custom_card.dart';
import 'package:crop_capture/constants/constants.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);
  static const routeName = '/history-page';

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late File imageFile;
  List<List<dynamic>> list = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<ImageProvider<Object>> getImage() async {
    File imageFile = await downloadImage(
        "https://images.pexels.com/photos/807598/pexels-photo-807598.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940");
    return FileImage(imageFile);
  }

  Future<File> downloadImage(String imageimage) async {
    final response = await http.get(Uri.parse(imageimage));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File(
        '${documentDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.png');
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  Widget customCard(String plant, String disease, ImageProvider<Object> image) {
    return CustomWidget(plant, disease, image);
  }

  Future<void> getListReady() async {
    list = [
      ['Rice', 'Blast', await getImage()],
      ['Rice', 'Healthy', await getImage()],
      ['Corn', 'Blight', await getImage()]
    ];
  }

  @override
  Widget build(BuildContext context) {
    getListReady();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: primaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                if (list[index].length == 3) {
                  return customCard(
                    list[index][0],
                    list[index][1],
                    list[index][2],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
