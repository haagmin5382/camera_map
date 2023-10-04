import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MypageScreen extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  late Function(bool) onLoginStateChanged;

  MypageScreen({super.key, required this.onLoginStateChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50, // 원의 반지름 설정
              backgroundImage: NetworkImage(user?.photoURL ?? ''), // 프로필 사진 표시
            ),
            const SizedBox(height: 20),
            _buildInputField(context, '이메일', user?.email ?? ''),

            const SizedBox(height: 10),
            _buildInputField(context, '이름', user?.displayName ?? ''),
            _buildLogoutButton(context, onLoginStateChanged)
            // 필요한 다른 사용자 정보 항목을 추가할 수 있습니다.
          ],
        ),
      ),
    );
  }
}

Widget _buildInputField(BuildContext context, String label, String value) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.8,
    child: TextField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white, // 칸 배경색
        contentPadding: const EdgeInsets.all(12), // 내용과 경계 사이 여백
      ),
      controller: TextEditingController(text: value),
      readOnly: true, // 읽기 전용
    ),
  );
}

Widget _buildLogoutButton(BuildContext context, onLoginStateChanged) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: ElevatedButton(
      onPressed: () async {
        // 로그아웃 로직 추가
        await FirebaseAuth.instance.signOut();
        onLoginStateChanged(false);
      },
      child: const Text('로그아웃'),
    ),
  );
}
