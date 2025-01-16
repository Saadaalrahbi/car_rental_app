class CarReviewModel{
  final String id;
  final String userId;
  final double ratings;
  final String? comment;
  final String? userName;
  final DateTime timestamp;
  final String? userImageUrl;
  final String? shopComment;
  final DateTime? shopTimestamp;


  CarReviewModel ({
    required this.id,
    required this.userId,
    required this.ratings,
    required this.timestamp,
    this.comment,
    this.userName,
    this.userImageUrl,
    this.shopComment,
    this.shopTimestamp
});

  ///empty function
 static CarReviewModel empty() => CarReviewModel(id: '', userId: '', ratings: 5, timestamp: DateTime.now());
 
}