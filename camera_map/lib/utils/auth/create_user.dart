import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

void createUser(User user) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users.doc(user.email).set({
    'email': user.email,
    'displayName': user.displayName,
    'photoURL': user.photoURL,
    'isLogin': true,
    'friends': []
  });
  // users
  //     .add({
  //       'email': user.email,
  //       'displayName': user.displayName,
  //       'isLogin': true
  //     })
  //     .then((value) => print("User Added"))
  //     .catchError((error) => print("Failed to add user: $error"));
}
