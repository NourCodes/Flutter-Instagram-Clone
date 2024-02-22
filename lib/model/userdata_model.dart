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
}
