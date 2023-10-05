import 'package:camera_map/screens/login_screen.dart';
import 'package:camera_map/screens/mypage_screen.dart';
import 'package:camera_map/widgets/header_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:camera_map/screens/chat_list_screen.dart';
import 'package:camera_map/screens/friends_list_screen.dart';
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

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      FriendListScreen(),
      ChatListScreen(),
      const MapScreen(),
      MypageScreen(onLoginStateChanged: onLoginStateChanged)
    ];

    return MaterialApp(
      title: 'Camera Map',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<User?>(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // 로딩 화면 표시
          } else {
            if (snapshot.hasData) {
              // 사용자가 로그인한 경우
              User? user = snapshot.data;
              if (user?.email != null) {
                return Scaffold(
                  appBar: AppBar(
                    actions: [
                      if (isLogin) // 로그인 상태에 따라 프로필 버튼 표시
                        const header()
                    ],
                  ),
                  body: Center(
                    child: pages[_selectedIndex],
                  ),
                  bottomNavigationBar: menubar(
                    // MenuBar 위젯을 사용
                    selectedIndex: _selectedIndex,
                    onItemTapped: _onItemTapped,
                  ),
                );
              } else {
                return LoginScreen(
                    isLogin: isLogin, onLoginStateChanged: onLoginStateChanged
                    // 로그인 화면 구성
                    );
              }
            } else {
              // 사용자가 로그인하지 않은 경우
              return LoginScreen(
                  isLogin: isLogin, onLoginStateChanged: onLoginStateChanged
                  // 로그인 화면 구성
                  );
            }
          }
        },
      ),
    );
  }
}
