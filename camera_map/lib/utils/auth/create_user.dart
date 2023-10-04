import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

void createUser(User user) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final userInDB = users.doc(user.email);
  // final userNotInDB = users.doc('nouser@email.com');
  userInDB.get().then((value) => {
        if (value.data() == null)
          {
            users.doc(user.email).set({
              'email': user.email,
              'displayName': user.displayName,
              'photoURL': user.photoURL,
              'isLogin': true,
              'friends': []
            })
          }
        else
          {}
      });
}
