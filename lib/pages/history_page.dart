import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as pth;

import '../constants/constants.dart';
import '../widgets/plant_details_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);
  static const routeName = '/history-page';

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with AutomaticKeepAliveClientMixin {
  List<File> _imageFiles = [];

  @override
  void initState() {
    super.initState();
    _loadSavedImages();
  }

  Future<void> _loadSavedImages() async {
    try {
      final directory = await getExternalStorageDirectory();
      final files = await directory?.list().toList();
      final imageFiles = files
          ?.where((file) => file.path.endsWith('.png'))
          .map((file) => File(file.path))
          .toList();
      setState(() {
        _imageFiles = imageFiles ?? [];
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to load saved images: $e');
      }
    }
  }

  List<String> getDetails(String path) {
    final fileName = pth.basename(path);
    final nameAndDisease = fileName.split('____');
    final details = nameAndDisease[0].split('_');
    final name = details[0];
    final disease = details.sublist(1, details.length).join(' ');
    if (kDebugMode) {
      print('Plant : $name\nDisease : $disease');
    }
    return [name, disease];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: onPrimaryColor,
      body: _imageFiles.isNotEmpty
          ? Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: _imageFiles.length,
                    itemBuilder: (BuildContext context, int index) {
                      final file = _imageFiles[index];
                      final details = getDetails(file.path);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 5,
                        ),
                        child: PlantWidget(
                          name: details[0],
                          disease: details[1],
                          imageFile: file,
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : const Center(
              child: Text('Welcome Aboard!'),
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
