import 'package:camera_map/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera_map/screens/camera_screen.dart';
import 'package:camera_map/screens/friends._screen.dart';
import 'package:camera_map/screens/map_screen.dart';
import 'package:camera_map/widgets/menu_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Firebase 설정
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    GalleryScreen(),
    const CameraScreen(),
    const MapScreen()
  ];
  final picker = ImagePicker();
  var isLogin = false;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onLoginStateChanged(bool loginState) {
    setState(() {
      isLogin = loginState;
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
      home: isLogin
          ? Scaffold(
              body: Center(
                child: _pages[_selectedIndex],
              ),
              bottomNavigationBar: menubar(
                // MenuBar 위젯을 사용
                selectedIndex: _selectedIndex,
                onItemTapped: _onItemTapped,
              ),
            )
          : LoginScreen(
              isLogin: isLogin, onLoginStateChanged: onLoginStateChanged),
    );
  }
}
