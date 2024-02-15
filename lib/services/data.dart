import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/services/storage.dart';

class Data {
  //create an instance of firebase firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void saveUserData(String email, String password, String fullName,
      String userName, String id, Uint8List file) async {
    String imageUrl = await Storage().uploadImage(file, false);

    await _firestore.collection("users").doc(id).set(
      {
        "email": email,
        "full name": fullName,
        "username": userName,
        "password": password,
        "id": id,
        "image": imageUrl,
        "followers": [],
        "following": [],
      },
    );
  }
}
