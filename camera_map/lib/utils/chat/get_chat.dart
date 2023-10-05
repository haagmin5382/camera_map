import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
User? user = FirebaseAuth.instance.currentUser;

Future<Stream<DocumentSnapshot<Object?>>> getChat(
    String? userEmail, String friendEmail) async {
  CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection('chats');
  final chatDocument = chatsCollection.doc('$userEmail:$friendEmail');
  final chatDocument2 = chatsCollection.doc('$friendEmail:$userEmail');

  if ((await chatDocument.get()).data() != null) {
    return chatDocument.snapshots();
  }
  if ((await chatDocument2.get()).data() != null) {
    return chatDocument2.snapshots();
  } else {
    // 필요한 경우, 기본 스트림을 반환하거나 예외 처리를 수행할 수 있습니다.
    return chatDocument.snapshots();
  }
}
