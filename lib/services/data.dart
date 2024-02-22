import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/services/storage.dart';
import '../model/userdata_model.dart';

class Data {
  //create an instance of firebase firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//this method takes userdata uploads profile image, creates a new UserDataModel instance using the provided data, converts it
// to JSON format using the toJson method, and then saves it to the Firestore database
  void saveUserData(String email, String password, String fullName,
      String userName, String id, Uint8List file) async {
    // upload user profile image to storage and get the image URL
    String imageUrl = await Storage().uploadImage(file, false);

    // create a UserDataModel instance with provided data
    UserDataModel userData = UserDataModel(
      email: email,
      fullName: fullName,
      userName: userName,
      password: password,
      imageUrl: imageUrl,
      followers: [],
      following: [],
      id: id,
    );

    await _firestore.collection("users").doc(id).set(userData.toJson());
  }
}
