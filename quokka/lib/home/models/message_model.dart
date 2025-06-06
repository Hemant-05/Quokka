class Message {
  final String id;
  final String? content;
  final String? imageUrl;
  final String? videoUrl;
  final String senderId;
  final String chatId;
  final DateTime createdAt;

  Message({
    required this.id,
    this.content,
    this.imageUrl,
    this.videoUrl,
    required this.senderId,
    required this.chatId,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      senderId: json['senderId'],
      chatId: json['chatId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'senderId': senderId,
      'chatId': chatId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
