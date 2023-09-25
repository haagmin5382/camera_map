import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
User? user = FirebaseAuth.instance.currentUser;

Future<Map<String, dynamic>> getChat(String friendEmail) async {
  final userEmail = user!.email;
  CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection('chats');
  final chatDocument = chatsCollection.doc('$userEmail:$friendEmail');
  final chatDocument2 = chatsCollection.doc('$friendEmail:$userEmail');
  if ((await chatDocument.get()).data() != null) {
    final Map<String, dynamic> chatsData =
        (await chatDocument.get()).data() as Map<String, dynamic>;
    return chatsData;
  }
  if ((await chatDocument2.get()).data() != null) {
    final Map<String, dynamic> chatsData =
        (await chatDocument2.get()).data() as Map<String, dynamic>;
    return chatsData;
  } else {
    return {};
  }
}
