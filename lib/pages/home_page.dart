import 'package:crop_capture/pages/constants.dart';
import 'package:crop_capture/pages/tflite_model/tflite_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:crop_capture/pages/history_page/history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  // ignore: non_constant_identifier_names
  List<Widget> widget_list = [
    const HistoryPage(),
    const TfliteModel(),
    const Text("Page 3")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Care'),
      ),
      backgroundColor: primaryColor,
      body: _selectedIndex != 1
          ? Center(
              child: widget_list[_selectedIndex],
            )
          : widget_list[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: primaryColor,
        buttonBackgroundColor: secondaryColor,
        color: Theme.of(context).primaryColor,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: primaryColor,
          ),
          Icon(
            Icons.camera_alt,
            size: 30,
            color: primaryColor,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: primaryColor,
          ),
        ],
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
