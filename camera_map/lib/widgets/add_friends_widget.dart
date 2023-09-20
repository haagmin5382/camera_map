import 'package:camera_map/utils/friends/add_friends.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendAddModal extends StatelessWidget {
  // 모달 다이얼로그에서 입력받을 이메일을 저장할 변수
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  FriendAddModal({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return AlertDialog(
      title: const Text('친구 추가'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailController,
            focusNode: emailFocusNode,
            decoration: const InputDecoration(
              hintText: '이메일을 입력하세요',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // 이메일을 사용하여 친구 추가 로직을 수행
              // emailController.text 변수에 입력된 이메일 사용
              print(emailController.text);
              addFriends(user, emailController.text);
              // ...
              Navigator.of(context).pop(); // 모달 닫기
            },
            child: const Text('추가'),
          ),
        ],
      ),
    );
  }
}
