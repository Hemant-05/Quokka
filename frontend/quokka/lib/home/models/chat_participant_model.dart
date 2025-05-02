class ChatParticipant {
  final String id;
  final String userId;
  final String chatId;
  final DateTime joinedAt;

  ChatParticipant({
    required this.id,
    required this.userId,
    required this.chatId,
    required this.joinedAt,
  });

  factory ChatParticipant.fromJson(Map<String, dynamic> json) {
    return ChatParticipant(
      id: json['id'],
      userId: json['userId'],
      chatId: json['chatId'],
      joinedAt: DateTime.parse(json['joinedAt']),
    );
  }
}