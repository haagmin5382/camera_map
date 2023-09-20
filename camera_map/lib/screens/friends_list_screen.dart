import 'package:camera_map/widgets/add_friends_widget.dart';
import 'package:flutter/material.dart';

class FriendListScreen extends StatelessWidget {
  // 친구 데이터 리스트 (예시)
  final List<Friend> friends = [
    Friend(name: '친구 1', isOnline: true, imageUrl: ''),
    Friend(name: '친구 2', isOnline: false, imageUrl: ''),
    Friend(name: '친구 3', isOnline: true, imageUrl: ''),
    // 추가 친구 데이터...
  ];

  FriendListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                final friend = friends[index];
                final statusIcon = friend.isOnline
                    ? const Icon(
                        Icons.circle,
                        color: Colors.green,
                        size: 10,
                      )
                    : const Icon(
                        Icons.circle,
                        color: Colors.grey,
                        size: 10,
                      );
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(friend.imageUrl),
                  ),
                  title: Row(
                    children: [
                      Text(friend.name),
                      const Spacer(), // 오른쪽에 공간 추가
                      statusIcon
                    ],
                  ),
                  onTap: () {
                    // 친구를 탭했을 때 수행할 동작 추가
                  },
                );
              },
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return FriendAddModal(); // FriendAddModal 위젯 표시
                },
              );
              // Respond to button press
            },
            icon: const Icon(Icons.add, size: 18),
            label: const Text("친구 추가하기"),
          )
        ],
      ),
    );
  }
}

class Friend {
  final String name;
  final bool isOnline;
  final String imageUrl;

  Friend({required this.name, required this.isOnline, required this.imageUrl});
}
