import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../plant_details.dart';

class PlantDetailsScreen extends StatelessWidget {
  static const String routeName = '/plant-details-screen';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final name = routeArgs!['name'];
    final disease = routeArgs['disease'];
    final imageFile = routeArgs['imageFile'].path;
    final plantDetailsList = PLANT_DETAILS.where((plant) {
      return plant.name == name && plant.disease == disease;
    }).toList();
    final plantDetails =
        plantDetailsList.isNotEmpty ? plantDetailsList.first : null;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                plantDetails != null ? plantDetails.disease : name,
                textAlign: TextAlign.start,
              ),
              background: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Hero(
                  tag: imageFile,
                  child: Image.file(
                    File(imageFile),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: plantDetails == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/icons/happy_plant.json',
                              height: 250.0,
                              width: 250.0,
                              fit: BoxFit.cover,
                              repeat: false,
                            ),
                            const SizedBox(height: 16.0),
                            const Text(
                              'Your plant is healthy!',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plantDetails.name,
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              plantDetails.type,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...plantDetails.symptoms
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final index = entry.key + 1;
                                  final symptom = entry.value;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$index. ',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            symptom,
                                            style:
                                                const TextStyle(fontSize: 16.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            const Text(
                              'Remedies:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...plantDetails.remedies.map((remedy) {
                                  final remedyParts = remedy.split(':');
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: remedyParts[0],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          TextSpan(text: ": ${remedyParts[1]}"),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 300.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
