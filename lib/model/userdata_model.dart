import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  final String id;
  final String email;
  final String fullName;
  final String userName;
  final String password;
  final String imageUrl;
  final List followers;
  final List following;
  UserDataModel({
    required this.email,
    required this.fullName,
    required this.userName,
    required this.password,
    required this.imageUrl,
    required this.followers,
    required this.following,
    required this.id,
  });

  // method to convert UserDataModel instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': userName,
      'id': id,
      'photoUrl': imageUrl,
      'followers': followers,
      'following': following,
    };
  }

  // static method to construct a UserDataModel instance from a Firestore document snapshot
  // This method takes a DocumentSnapshot as input, extracts the necessary data from it,
  // and constructs a UserDataModel instance with the extracted data
  static UserDataModel fromSnap(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);
    return UserDataModel(
        email: snapshot['email'],
        fullName: snapshot['full name'],
        userName: snapshot['username'],
        password: snapshot['password'],
        imageUrl: snapshot['image'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        id: snapshot['id']);
  }
}
