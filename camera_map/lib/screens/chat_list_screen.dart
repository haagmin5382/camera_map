import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  // 채팅방 목록 데이터 (예시)
  final List<ChatRoom> chatRooms = [
    ChatRoom(
      name: '친구 1',
      lastMessage: '안녕하세요!',
      unreadCount: 2,
    ),
    ChatRoom(
      name: '친구 2',
      lastMessage: '오랜만이에요!',
      unreadCount: 0,
    ),
    ChatRoom(
      name: '친구 3',
      lastMessage: '뭐해요?',
      unreadCount: 5,
    ),
    // 추가 채팅방 데이터...
  ];

  ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('채팅방 목록', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: chatRooms.length,
        itemBuilder: (context, index) {
          final chatRoom = chatRooms[index];
          return ListTile(
            leading: const CircleAvatar(
              // 채팅 상대방의 프로필 사진 등
              backgroundColor: Colors.blue, // 예시용 색상
            ),
            title: Text(chatRoom.name),
            subtitle: Text(chatRoom.lastMessage),
            trailing: chatRoom.unreadCount > 0
                ? CircleAvatar(
                    // 읽지 않은 메시지 수를 표시하는 아이콘
                    backgroundColor: Colors.red, // 예시용 색상
                    child: Text(
                      chatRoom.unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  )
                : null,
            onTap: () {
              // 채팅방을 터치했을 때 채팅방으로 이동하는 동작 추가
              // 예: 해당 채팅방 화면으로 이동
              print('채팅방을 터치했습니다: ${chatRoom.name}');
            },
          );
        },
      ),
    );
  }
}

class ChatRoom {
  final String name;
  final String lastMessage;
  final int unreadCount;

  ChatRoom({
    required this.name,
    required this.lastMessage,
    required this.unreadCount,
  });
}
