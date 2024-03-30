import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/model/post_model.dart';
import 'package:instagram_clone/services/storage.dart';
import 'package:instagram_clone/utilities/utils.dart';
import '../model/comment_model.dart';
import '../model/userdata_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class Data {
  // generate a unique ID for the post
  final String postId = const Uuid().v1();
  final String commentId =
      const Uuid().v1(); // generate a unique ID for the comment.

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

  // this method checks if the user ID is already in the list of likes
  Future likePost(String postId, String id, List likes) async {
    try {
      // if the user has already liked the post, then their ID is removed from the likes list
      if (likes.contains(id)) {
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([id]),
        });
      } else {
        // if the user hasn't liked the post yet, then their ID is added to the likes list
        await _firestore.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([id]),
        });
      }
    } catch (e) {
      return (e.toString());
    }
  }

// this method is for posting a comment
  Future postComments(String postId, String description, String username,
      String userId, String image) async {
    try {
      // check if the comment description is not empty
      if (description.isNotEmpty) {
        // create a CommentModel instance
        CommentModel comment = CommentModel(
            description: description,
            userName: username,
            postId: postId,
            datePublished: DateTime.now(),
            userId: userId,
            commentId: commentId,
            profImage: image,
            liked: false);
        // store the comment data in Firestore
        await _firestore
            .collection("posts")
            .doc(postId)
            .collection("comments")
            .doc(commentId)
            .set(comment.toJson());
      } else {
        print("There is no text");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> comments(String postId) {
    return _firestore
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .orderBy("datePublished", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getComments(String postId) async {
    return await _firestore
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .get();
  }

  //this method is for deleting post
  Future deletePost(String postId) async {
    try {
      return await _firestore.collection("posts").doc(postId).delete();
    } catch (e) {
      showMessage(e.toString());
    }
  }

  // this method searches for users whose usernames are greater than or equal to the provided user string
  Future searchUsers(String user) async {
    return await _firestore
        .collection("users")
        .where(("username"), isGreaterThanOrEqualTo: user)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> get posts {
    return _firestore.collection("posts").get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String id) async {
    try {
      return await _firestore.collection("users").doc(id).get();
    } catch (e) {
      showMessage(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<int> getNumberOfPosts(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection("posts")
          .where("id", isEqualTo: userId)
          .get();
      return snapshot.docs.length;
    } catch (e) {
      showMessage(e.toString());
      throw Exception(e.toString());
    }
  }
}
