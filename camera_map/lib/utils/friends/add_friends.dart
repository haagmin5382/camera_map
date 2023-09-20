import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addFriends(User? user, String friendEmail) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final userInDB = users.doc(friendEmail);
  Map<String, dynamic> friendAccount;
  userInDB.get().then((value) => {
        if (value.data() != null)
          {
            // 추가하는 자의 계정
            users.doc(user!.email).set({
              'email': user.email,
              'displayName': user.displayName,
              'photoURL': user.photoURL,
              'isLogin': true,
              'friends': [friendEmail]
            }),
            friendAccount = value.data() as Map<String, dynamic>,
            // 추가되는 자의 계정
            users.doc(friendEmail).set({
              ...friendAccount,
              'email': friendEmail,
              'friends': [user.email]
            })
          }
      });
}
