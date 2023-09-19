import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  // Firebase 사용자 객체
  User? user = FirebaseAuth.instance.currentUser;

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print(user);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(user?.displayName ?? ''),
              accountEmail: Text(user?.email ?? ''),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(user?.photoURL ?? ''),
              ),
            ),
            // 다른 프로필 정보 표시
            // ...
          ],
        ),
      ),
    );
  }
}
