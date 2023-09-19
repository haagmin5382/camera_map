import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class header extends StatefulWidget {
  const header({super.key});

  @override
  State<header> createState() => _headerState();
}

class _headerState extends State<header> {
  User? user = FirebaseAuth.instance.currentUser;
  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isMenuOpen = !isMenuOpen;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12.0), // 오른쪽 여백 설정
        child: Stack(
          children: [
            ClipOval(
              child: Image.network(
                user?.photoURL ?? '기본 이미지 URL',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
