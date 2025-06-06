part of 'chat_list_bloc.dart';

abstract class ChatListEvent {}
class LoadChatList extends ChatListEvent {}
class LoadUserChats extends ChatListEvent {
  final String userId;
  LoadUserChats(this.userId);
}
class UpdateChatListWithNewMessage extends ChatListEvent {
  final Message message;
  UpdateChatListWithNewMessage(this.message);
}
class MarkChatAsRead extends ChatListEvent {
  final String chatId;
  MarkChatAsRead(this.chatId);
}