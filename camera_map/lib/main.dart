import 'package:camera_map/screens/login_screen.dart';
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

  final List<Widget> _pages = [
    FriendListScreen(),
    ChatListScreen(),
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

  User? user = FirebaseAuth.instance.currentUser;
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
              appBar: AppBar(
                actions: [
                  if (isLogin) // 로그인 상태에 따라 프로필 버튼 표시
                    Container(
                      margin: const EdgeInsets.only(right: 12.0),
                      child: ClipOval(
                        child: Image.network(
                          user?.photoURL ??
                              '기본 이미지 URL', // 사용자 프로필 사진 URL 또는 기본 이미지 URL
                          width: 50, // 원하는 너비
                          height: 50, // 원하는 높이
                          fit: BoxFit.cover, // 이미지를 알맞게 조절하도록 설정
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return const CircularProgressIndicator(); // 이미지 로딩 중에는 로딩 인디케이터 표시
                            }
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Icon(
                                Icons.error); // 이미지 로딩 오류 시 기본 아이콘 표시
                          },
                        ),
                      ),
                    )
                ],
              ),
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
