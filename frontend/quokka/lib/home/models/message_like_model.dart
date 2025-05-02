class MessageLike {
  final String id;
  final String userId;
  final String messageId;

  MessageLike({
    required this.id,
    required this.userId,
    required this.messageId,
  });

  factory MessageLike.fromJson(Map<String, dynamic> json) {
    return MessageLike(
      id: json['id'],
      userId: json['userId'],
      messageId: json['messageId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'messageId': messageId,
    };
  }
}