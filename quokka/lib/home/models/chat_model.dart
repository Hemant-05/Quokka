import 'package:quokka/home/models/chat_participant_model.dart';

import 'message_model.dart';

class Chat {
  final String id;
  final DateTime createdAt;
  final List<ChatParticipant>? chatParticipants;
  final Message? lastMessage;
  final String? name;
  final List<Message>? messages;
  final Map<String, dynamic>? otherUser;

  Chat({
    this.name,
    this.lastMessage,
    this.chatParticipants,
    this.messages,
    this.otherUser,
    required this.id,
    required this.createdAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      name: json['name'],
      lastMessage: json['lastMessage'] != null? Message.fromJson(json['lastMessage']) : null,
      otherUser: json['otherUser'],
      createdAt: DateTime.parse(json['createdAt']),
      chatParticipants: json['chatParticipants'] != null? (json['chatParticipants'] as List<dynamic>?)
          ?.map((e) => ChatParticipant.fromJson(e))
          .toList() : null,
      messages: (json['messages'] as List<dynamic>?)?.map((e) => Message.fromJson(e)).toList(),
    );
  }
}
