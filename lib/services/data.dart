import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/model/post_model.dart';
import 'package:instagram_clone/services/storage.dart';
import 'package:instagram_clone/utilities/utils.dart';
import '../model/userdata_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class Data {
  //create an instance of Firebase Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// This method fetches the user's details from Firestore using their UID,
// then constructs a UserDataModel instance from the retrieved data
  Future<UserDataModel> getUserDetails() async {
    //get current user
    User currUser = FirebaseAuth.instance.currentUser!;
    // fetch user data snapshot from Firestore
    DocumentSnapshot userDataSnap =
        await _firestore.collection('users').doc(currUser.uid).get();
    // construct a UserDataModel instance from the retrieved data
    UserDataModel userData = UserDataModel.fromSnap(userDataSnap);
    return userData;
  }

// uploads a post to Firestore
  Future uploadPost(
    String id,
    String username,
    Uint8List image,
    String description,
    String profileImage,
  ) async {
    // initialize an empty string to store a message
    String message = "";
    try {
      // generate a unique ID for the post
      String postId = const Uuid().v1();
      // upload the image and get the URL
      String imageUrl = await Storage().uploadImage(image, true, "postImage");
      // create a Post object with the provided data
      PostModel post = PostModel(
        profImage: profileImage,
        description: description,
        id: id,
        userName: username,
        datePublished: DateTime.now(),
        imageUrl: imageUrl,
        likes: [],
        postId: postId,
      );
      // store the post data in Firestore
      await _firestore.collection("posts").doc(postId).set(
            post.toJson(),
          );
      message = "Posted";
    } catch (err) {
      // if an error occurs, store the error message
      message = err.toString();
    }
    // show the message to the user
    showMessage(message);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get getPost {
    return _firestore
        .collection("posts")
        .orderBy("datePublished", descending: true)
        .snapshots();
  }

//this method takes userdata uploads profile image, creates a new UserDataModel instance using the provided data, converts it
// to JSON format using the toJson method, and then saves it to the Firestore database
  Future<void> saveUserData(String email, String password, String fullName,
      String userName, String id, Uint8List file) async {
    // upload user profile image to storage and get the image URL
    String imageUrl = await Storage().uploadImage(file, false, "profileImages");

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
