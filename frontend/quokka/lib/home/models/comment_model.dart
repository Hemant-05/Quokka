class Comment {
  final String id;
  final String content;
  final DateTime createdAt;
  final String userId;
  final String? postId;
  final String? reelId;

  Comment({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.userId,
    this.postId,
    this.reelId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      userId: json['userId'],
      postId: json['postId'],
      reelId: json['reelId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
      'postId': postId,
      'reelId': reelId,
    };
  }
}