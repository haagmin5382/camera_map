import 'package:camera_map/utils/friends/get_friends.dart';
import 'package:camera_map/widgets/add_friends_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendListScreen extends StatelessWidget {
  // 친구 데이터 리스트 (예시)

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  User? user = FirebaseAuth.instance.currentUser;

  FriendListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final myAccount = users.doc(user!.email);
    Map<String, dynamic> myDBInfo;
    List<String> friendList;
    myAccount.get().then((value) => {
          myDBInfo = value.data() as Map<String, dynamic>,
          friendList = List<String>.from(myDBInfo['friends'])
        });

    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: myAccount.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // 데이터를 아직 불러오지 않았을 때의 UI
                  return const CircularProgressIndicator(); // 예시로 로딩 스피너를 표시
                } else if (snapshot.hasError) {
                  // 에러가 발생했을 때의 UI
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.data() == null) {
                  // 데이터가 없을 때의 UI
                  return const Text('No data available');
                } else {
                  // 데이터를 성공적으로 불러온 경우
                  myDBInfo = snapshot.data!.data() as Map<String, dynamic>;
                  friendList = List<String>.from(myDBInfo['friends']);
                  return Expanded(
                    child: ListView.builder(
                      itemCount: friendList.length,
                      itemBuilder: (context, index) {
                        final friend = friendList[index];

                        return FutureBuilder(
                            future: getFriends(friend),
                            builder: (context, snapshot2) {
                              if (snapshot2.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot2.hasError) {
                                return Text('에러 발생: ${snapshot.error}');
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
                                    backgroundImage:
                                        NetworkImage(friendData['photoURL']),
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
                                  },
                                );
                              } else {
                                return const Text(
                                    '데이터 없음'); // 데이터가 없을 경우 기본값 반환
                              }
                            });
                      },
                    ),
                  );
                }
              }),
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
  final String email;
  final String displayName;
  final bool isLogin;
  final String photoURL;

  Friend(
      {required this.email,
      required this.displayName,
      required this.isLogin,
      required this.photoURL});
}
