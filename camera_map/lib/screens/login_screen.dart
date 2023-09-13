import 'package:camera_map/utils/auth/create_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  bool isLogin;
  final Function(bool) onLoginStateChanged;

  LoginScreen(
      {super.key, required this.isLogin, required this.onLoginStateChanged});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User user = authResult.user!;
      createUser(user);
      return user;
    } catch (error) {
      print(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('Camera Map', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () async {
                final User? user = await _handleSignIn();
                if (user != null) {
                  // 로그인 성공 후 처리
                  widget.onLoginStateChanged(true);
                  print("로그인 성공: ${user.displayName}");
                } else {
                  // 로그인 실패 처리
                  print("로그인 실패");
                }
              },
              child: Container(
                width: 220,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 250, 248, 248),
                  borderRadius: BorderRadius.circular(5.0), // 큰 테두리를 추가
                  border: Border.all(
                    color: Colors.black.withOpacity(0.2), // 테두리 색상
                    width: 1.2, // 테두리 두께
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/google_logo.png', // 로고 이미지 경로
                      width: 50,
                      height: 40,
                    ),
                    const SizedBox(width: 10),
                    // const Icon(Icons.googleSignIn),
                    const Text(
                      'Google 로그인',
                      style: TextStyle(
                        color: Color.fromARGB(221, 115, 107, 107),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
