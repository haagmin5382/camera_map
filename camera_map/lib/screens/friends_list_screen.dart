import 'package:flutter/material.dart';

class FriendListScreen extends StatelessWidget {
  // 친구 데이터 리스트 (예시)
  final List<Friend> friends = [
    Friend(name: '친구 1', status: '온라인', imageUrl: 'assets/friend1.png'),
    Friend(name: '친구 2', status: '오프라인', imageUrl: 'assets/friend2.png'),
    Friend(name: '친구 3', status: '온라인', imageUrl: 'assets/friend3.png'),
    // 추가 친구 데이터...
  ];

  FriendListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('친구 목록', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(friend.imageUrl),
            ),
            title: Text(friend.name),
            subtitle: Text(friend.status),
            // 친구를 탭했을 때 추가 동작을 설정할 수 있습니다.
            onTap: () {
              // 친구를 탭했을 때 수행할 동작 추가
              // 예: 채팅 화면으로 이동
            },
          );
        },
      ),
    );
  }
}

class Friend {
  final String name;
  final String status;
  final String imageUrl;

  Friend({required this.name, required this.status, required this.imageUrl});
}
