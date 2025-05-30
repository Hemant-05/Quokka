part of 'chat_bloc.dart';

abstract class ChatEvent {}

class JoinChatRoom extends ChatEvent {
  final String chatId;
  JoinChatRoom(this.chatId);
}

class LeaveChatRoom extends ChatEvent {
  final String chatId;
  LeaveChatRoom(this.chatId);
}

class LoadChatMessagesEvent extends ChatEvent {
  final String chatId;
  LoadChatMessagesEvent(this.chatId);
}

class SendMessageEvent extends ChatEvent {
  final String message;
  final String chatId;
  final String senderId;
  SendMessageEvent(this.message, this.chatId, this.senderId);
}

class ReceiveMessageEvent extends ChatEvent {
  final Message message;
  ReceiveMessageEvent(this.message);
}
