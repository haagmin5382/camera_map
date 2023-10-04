import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  Widget build(BuildContext context) {
    final chatStream = chatsCollection
        .doc('$widget.userEmail:$widget.friendEmail')
        .snapshots();
    final chatStream2 = chatsCollection
        .doc('$widget.friendEmail:$widget.userEmail')
        .snapshots();
    return StreamBuilder<DocumentSnapshot>(
        stream: chatStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('에러 발생: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final chatData = snapshot.data!;
            final data = snapshot.data!.data();

            print('chatContent');
            print(data);
            // if (chatData['chatting'] != null) {
            //   return ListView.builder(
            //     itemCount: chatData['chatting']?.length,
            //     itemBuilder: (context, index) {
            //       return ChatMessage(
            //           text: chatData['chatting'][index]['message'],
            //           isUser: chatData['chatting'][index]['user'] !=
            //               widget.friendEmail);
            //     },
            //   );
            // }
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
