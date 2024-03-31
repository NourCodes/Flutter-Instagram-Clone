import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  final String id;
  final String email;
  final String fullName;
  final String userName;
  final String? bio; // optional bio field
  final String password;
  final String imageUrl;
  final List followers;
  final List following;
  UserDataModel({
    required this.email,
    required this.fullName,
    required this.userName,
    this.bio,
    required this.password,
    required this.imageUrl,
    required this.followers,
    required this.following,
    required this.id,
  });

  // method to convert UserDataModel instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      "bio": bio,
      'email': email,
      'full name': fullName,
      'username': userName,
      'id': id,
      'photoUrl': imageUrl,
      'followers': followers,
      'following': following,
    };
  }

  // Static method to construct a UserDataModel instance from a Firestore document snapshot
  static UserDataModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>?;

    if (snapshot == null) {
      throw Exception("Snapshot data is null");
    }

    return UserDataModel(
      bio: snapshot["bio"], // optional bio field
      email: snapshot['email'] ?? '',
      fullName: snapshot['full name'] ?? '',
      userName: snapshot['username'] ?? '',
      password: snapshot['password'] ?? '',
      imageUrl: snapshot['photoUrl'] ?? '',
      followers: List.from(snapshot['followers'] ?? []),
      following: List.from(snapshot['following'] ?? []),
      id: snapshot['id'] ?? '',
    );
  }
}
