import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  //create an instance of firebase firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void saveUserData(String email, String password, String fullName,
      String userName, String id) async {
    await _firestore.collection("users").doc(id).set(
      {
        "email": email,
        "full name": fullName,
        "username": userName,
        "password": password,
        "id": id,
        "followers": [],
        "following": [],
      },
    );
  }
}
