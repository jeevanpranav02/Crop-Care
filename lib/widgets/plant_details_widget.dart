import 'dart:io';

import 'package:crop_capture/constants/constants.dart';
import 'package:crop_capture/pages/plant_details_screen.dart';
import 'package:flutter/material.dart';

class PlantWidget extends StatelessWidget {
  const PlantWidget({
    required this.name,
    required this.disease,
    required this.imageFile,
  });

  final String name;
  final String disease;
  final File imageFile;

  void selectPlant(BuildContext context) {
    Navigator.of(context).pushNamed(PlantDetailsScreen.routeName, arguments: {
      'name': name,
      'disease': disease,
      'imageFile': imageFile,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectPlant(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Hero(
                      tag: imageFile.path,
                      child: Image.file(
                        imageFile,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 60,
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 20,
                              color: textColor2,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          Text(
                            disease,
                            style: const TextStyle(
                              fontSize: 15,
                              color: textColor2Lite,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 15,
                    color: iconColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
