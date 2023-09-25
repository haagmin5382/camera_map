import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> getFriends(String friendEmail) async {
  final document = await FirebaseFirestore.instance
      .collection('users')
      .doc(friendEmail)
      .get();
  if (document.exists) {
    print('함수 내부');
    print(document.data());
    return document.data() as Map<String, dynamic>;
  } else {
    throw Exception('친구 데이터를 찾을 수 없습니다.');
  }
}
