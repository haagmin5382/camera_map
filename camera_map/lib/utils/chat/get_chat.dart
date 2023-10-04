import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
User? user = FirebaseAuth.instance.currentUser;

Future<Object> getChat(String friendEmail) async {
  final userEmail = user!.email;
  CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection('chats');
  final chatDocument = chatsCollection.doc('$userEmail:$friendEmail');
  final chatDocument2 = chatsCollection.doc('$friendEmail:$userEmail');
  if ((await chatDocument.get()).data() != null) {
    final chatStream = chatDocument.snapshots();

    final Map<String, dynamic> chatsData =
        (await chatDocument.get()).data() as Map<String, dynamic>;
    return chatStream;
  }
  if ((await chatDocument2.get()).data() != null) {
    final chatStream = chatDocument2.snapshots();
    final Map<String, dynamic> chatsData =
        (await chatDocument2.get()).data() as Map<String, dynamic>;
    return chatStream;
  } else {
    return {};
  }
}
