import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addFriends(User user) {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final userInDB = users.doc(user.email);
}
