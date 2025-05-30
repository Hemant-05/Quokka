import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat_model.dart';
import '../../models/message_model.dart';
import '../../repository/chat_repository.dart';

part 'chat_list_event.dart';

part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository repository;

  ChatListBloc(this.repository) : super(ChatListInitial()) {
    on<LoadUserChats>((event, emit) async {
      emit(ChatListLoading());
      try {
        final chats = await repository.getUserChats();
        emit(ChatListLoaded(chats));
      } catch (e) {
        emit(ChatListError(e.toString()));
      }
    });
    on<UpdateChatListWithNewMessage>((event, emit) async {
      if (state is ChatListLoaded) {
        final currentState = state as ChatListLoaded;
        // final chats = currentState.chats;
        final updatedChats =
        currentState.chats.map((chat) {
          if (chat.id == event.message.chatId) {
            return Chat(createdAt: chat.createdAt,
                lastMessage: event.message,
                name: chat.name,
                otherUser: chat.otherUser,
                chatParticipants: chat.chatParticipants,
                messages: chat.messages,
                id: chat.id);
          }
          return chat;
        }).toList();
          updatedChats.sort((a, b) => b.lastMessage!.createdAt.compareTo(a.lastMessage!.createdAt));

      emit(ChatListLoaded(updatedChats));
    }
    });
  }
}
