import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

void addChat(String? userEmail, String friendEmail, String message) async {
  CollectionReference chatsCollection =
      FirebaseFirestore.instance.collection('chats');
  final chatDocument = chatsCollection.doc('$userEmail:$friendEmail');
  final chatDocument2 = chatsCollection.doc('$friendEmail:$userEmail');
  if ((await chatDocument.get()).data() != null) {
    final Map<String, dynamic> chatsData =
        (await chatDocument.get()).data() as Map<String, dynamic>;

    chatsCollection.doc('$userEmail:$friendEmail').set({
      'chatting': [
        ...(chatsData['chatting']),
        {'user': userEmail, 'message': message}
      ]
    });
  } else if ((await chatDocument2.get()).data() != null) {
    final Map<String, dynamic> chatsData =
        (await chatDocument2.get()).data() as Map<String, dynamic>;

    chatsCollection.doc('$friendEmail:$userEmail').set({
      'chatting': [
        ...(chatsData['chatting']),
        {'user': userEmail, 'message': message}
      ]
    });
  } else {
    chatsCollection.doc('$userEmail:$friendEmail').set({
      'chatting': [
        {'user': userEmail, 'message': message}
      ]
    });
  }
}
