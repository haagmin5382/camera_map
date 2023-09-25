import 'package:camera_map/screens/chat_list_screen.dart';
import 'package:camera_map/screens/chat_room.dart';
import 'package:camera_map/utils/friends/get_friends.dart';
import 'package:flutter/material.dart';

class friendsList extends StatelessWidget {
  final friend;
  const friendsList({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFriends(friend),
        builder: (context, snapshot2) {
          if (snapshot2.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot2.hasError) {
            return Text('에러 발생: ${snapshot2.error}');
          } else if (snapshot2.hasData) {
            final friendData = snapshot2.data!;
            final statusIcon = friendData['isLogin']
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
                backgroundImage: NetworkImage(friendData['photoURL']),
              ),
              title: Row(
                children: [
                  Text(friendData['displayName']),
                  const Spacer(),
                  statusIcon
                ],
              ),
              onTap: () {
                // 친구를 탭했을 때 수행할 동작 추가
                final ChatRoom chatRoom = ChatRoom(
                    email: friendData['email'],
                    displayName: friendData['displayName'],
                    lastMessage: '',
                    unreadCount: 0);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoomScreen(chatRoom: chatRoom),
                  ),
                );
              },
            );
          } else {
            return const Text('데이터 없음'); // 데이터가 없을 경우 기본값 반환
          }
        });
  }
}
