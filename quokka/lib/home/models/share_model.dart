class Share {
  final String id;
  final String userId;
  final String? postId;
  final String? reelId;

  Share({
    required this.id,
    required this.userId,
    this.postId,
    this.reelId,
  });

  factory Share.fromJson(Map<String, dynamic> json) {
    return Share(
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