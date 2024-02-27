class PostModel {
  final String description;
  final String id;
  final String userName;
  final String postId;
  final DateTime datePublished;
  final String imageUrl;
  final String profImage;
  final likes;
  PostModel({
    required this.profImage,
    required this.description,
    required this.id,
    required this.userName,
    required this.postId,
    required this.datePublished,
    required this.imageUrl,
    required this.likes,
  });

  // method to convert PostModel instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'username': userName,
      'id': id,
      'postId': postId,
      'datePublished': datePublished,
      'profImage': profImage,
      "likes": likes,
      "postUrl": imageUrl,
    };
  }
}
