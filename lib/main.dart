import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import './pages/history_page/history_page.dart';
import './pages/tflite_model/tflite_model.dart';
import './pages/constants.dart';
import './pages/home_page.dart';
import './pages/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crop Care',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
        ),
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        HomePage.routeName: (context) => const HomePage(),
        TfliteModel.routeName: (context) => const TfliteModel(),
        HistoryPage.routeName: (context) => const HistoryPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
