import 'package:flutter/material.dart';
import 'package:camera_map/screens/camera_screen.dart';
import 'package:camera_map/screens/gallery._screen.dart';
import 'package:camera_map/screens/map_screen.dart';
import 'package:camera_map/widgets/menu_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [GalleryScreen(), CameraScreen(), MapScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Map',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: _pages[_selectedIndex],
        ),
        bottomNavigationBar: menubar(
          // MenuBar 위젯을 사용
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
