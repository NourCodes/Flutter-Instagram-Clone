class CommentModel {
  final String description;
  final String userName;
  final String postId;
  final DateTime datePublished;
  final String commentId;
  final String userId;
  final String profImage;
  final bool liked;

  CommentModel({
    required this.commentId,
    required this.userId,
    required this.profImage,
    required this.liked,
    required this.description,
    required this.userName,
    required this.postId,
    required this.datePublished,
  });

  // method to convert CommentModel instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'username': userName,
      'postId': postId,
      'datePublished': datePublished,
      "commentId": commentId,
      "userId": userId,
      "liked": false,
      "profImage": profImage,
    };
  }
}
