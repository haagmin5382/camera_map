import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addFriends(User? user, String friendEmail) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final friendDBInfo = users.doc(friendEmail);
  final myDBInfo = users.doc(user!.email);
  Map<String, dynamic> friendAccount;
  Map<String, dynamic> myAccount;
  List<String> friendList;

  friendDBInfo.get().then((value) => {
        if (value.data() != null)
          {
            // 추가하는 자의 계정
            myDBInfo.get().then((value) => {
                  myAccount = value.data() as Map<String, dynamic>,
                  friendList = List<String>.from(myAccount['friends']),
                  users.doc(user.email).set({
                    ...myAccount,
                    'friends': [...friendList, friendEmail]
                  }),
                }),

            // 추가되는 자의 계정
            friendAccount = value.data() as Map<String, dynamic>,
            friendList = List<String>.from(friendAccount['friends']),
            users.doc(friendEmail).set({
              ...friendAccount,
              'friends': [...friendList, user.email]
            })
          }
      });
}
