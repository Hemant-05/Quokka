class Like {
  final String id;
  final String userId;
  final String? postId;
  final String? reelId;

  Like({
    required this.id,
    required this.userId,
    this.postId,
    this.reelId,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['id'],
      userId: json['userId'],
      postId: json['postId'],
      reelId: json['reelId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'postId': postId,
      'reelId': reelId,
    };
  }
}