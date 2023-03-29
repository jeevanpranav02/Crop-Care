import 'package:flutter/material.dart';

import './pages/history_page.dart';
import './pages/plant_details_screen.dart';
import './pages/tflite_model.dart';
import './pages/home_page.dart';
import './pages/splash_screen.dart';
import './constants/constants.dart';
import './pages/profile_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crop Care',
      theme: ThemeData(
        primaryColor: primaryColor,
        primarySwatch: primaryColorSwatch,
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        HomePage.routeName: (context) => const HomePage(),
        TfliteModel.routeName: (context) => TfliteModel(),
        HistoryPage.routeName: (context) => const HistoryPage(),
        PlantDetailsScreen.routeName: (context) => PlantDetailsScreen(),
        ProfilePage.routeName: (context) => ProfilePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
