import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/constants.dart';
import './tflite_model.dart';
import './history_page.dart';
import './profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  Future<void> requestStoragePermission() async {
    final PermissionStatus status = await Permission.storage.request();
    if (status != PermissionStatus.granted) {
      throw Exception('Permission denied');
    }
  }

  int _selectedIndex = 1;
  final List<Widget> _pages = [
    const HistoryPage(),
    TfliteModel(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Care'),
      ),
      backgroundColor: onPrimaryColor,
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: primaryColor,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.camera_alt),
            label: 'Camera',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        animationDuration: const Duration(milliseconds: 300),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
