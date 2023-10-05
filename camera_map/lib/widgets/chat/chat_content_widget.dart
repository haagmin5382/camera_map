import 'package:camera_map/utils/chat/get_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class getChatContent extends StatefulWidget {
  final friendEmail;
  const getChatContent({super.key, required this.friendEmail});

  @override
  State<getChatContent> createState() => _getChatContentState();
}

class _getChatContentState extends State<getChatContent> {
  final CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection('chats');
  User? user = FirebaseAuth.instance.currentUser;
  var currentChatRoom = '';

  @override
  void initState() {
    super.initState();
    loadChatStream();
  }

  Future<void> loadChatStream() async {
    currentChatRoom = await getChat(widget.friendEmail);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userEmail = user!.email;
    final friendEmail = widget.friendEmail;

    final chatStream1 =
        chatsCollection.doc('$userEmail:$friendEmail').snapshots();
    final chatStream2 =
        chatsCollection.doc('$friendEmail:$userEmail').snapshots();
    print(currentChatRoom);
    return StreamBuilder<DocumentSnapshot>(
        stream: currentChatRoom == 'chat1' ? chatStream1 : chatStream2,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('에러 발생: ${snapshot.error}');
          } else if (snapshot.hasData) {
            if (snapshot.data?.data() != null) {
              final chatData = snapshot.data?.data() as Map<String, dynamic>;
              if (chatData['chatting'] != null) {
                final chattingList = chatData['chatting']
                    as List<dynamic>; // chatting을 List로 캐스트
                return ListView.builder(
                  itemCount: chattingList.length,
                  itemBuilder: (context, index) {
                    return ChatMessage(
                      text: chattingList[index]['message'],
                      isUser: chattingList[index]['user'] != widget.friendEmail,
                    );
                  },
                );
              }
            }
            return const Text('');
          } else {
            return const Text('데이터 없음'); // 데이터가 없을 경우 기본값 반환
          }
        });
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
