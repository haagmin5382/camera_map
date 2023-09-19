import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class profileMenu extends StatefulWidget {
  bool isMenuOpen;
  profileMenu({super.key, required this.isMenuOpen});

  @override
  State<profileMenu> createState() => _profileMenuState();
}

class _profileMenuState extends State<profileMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // 애니메이션 지속 시간 설정
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Firebase 사용자 객체
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      bottom: 0,
      left: 0,
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.isMenuOpen = !widget.isMenuOpen;
          }); // 프로필 메뉴 외부를 터치하면 메뉴를 닫습니다.
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // 화면 너비의 80%
          height: double.infinity,
          color: Colors.blue, // 하늘색 배경
          // 나머지 프로필 메뉴 구성 코드를 추가합니다.
        ),
      ),
    );
  }
}
