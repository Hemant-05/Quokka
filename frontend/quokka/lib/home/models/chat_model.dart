import 'package:quokka/home/models/chat_participant_model.dart';

import 'message_model.dart';

class Chat {
  final String id;
  final String userId;
  final String chatId;
  final DateTime joinedAt;
  final List<ChatParticipant>? chatParticipants;
  final Message? lastMessage;
  final int? unseenCount;
  final String? name;
  final List<Message>? messages;

  Chat({
    this.name,
    this.lastMessage,
    this.unseenCount,
    this.chatParticipants,
    this.messages,
    required this.id,
    required this.userId,
    required this.chatId,
    required this.joinedAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      userId: json['userId'],
      chatId: json['chatId'],
      name: json['name'],
      lastMessage: Message.fromJson(json['lastMessage']),
      unseenCount: json['unseenCount'],
      joinedAt: DateTime.parse(json['joinedAt']),
      chatParticipants: (json['chatParticipants'] as List<dynamic>?)
          ?.map((e) => ChatParticipant.fromJson(e))
          .toList(),
      messages: (json['messages'] as List<dynamic>?)?.map((e) => Message.fromJson(e)).toList(),
    );
  }
}
