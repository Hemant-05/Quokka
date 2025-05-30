part of 'chat_list_bloc.dart';


abstract class ChatListState extends Equatable {
  @override
  List<Object?> get props => [];
}
class ChatListInitial extends ChatListState {}
class ChatListLoading extends ChatListState {}
class ChatListLoaded extends ChatListState {
  final List<Chat> chats;
  ChatListLoaded(this.chats);
  @override
  List<Object?> get props => [chats];
}
class ChatListError extends ChatListState {
  final String message;
  ChatListError(this.message);
  @override
  List<Object?> get props => [message];
}