import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat_model.dart';
import '../../repository/chat_repository.dart';
part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository repository;

  ChatListBloc(this.repository) : super(ChatListLoading()) {
    on<LoadChatList>((event, emit) async {
      emit(ChatListLoading());
      try {
        final chats = await repository.getUserChats();
        emit(ChatListLoaded(chats));
      } catch (e) {
        emit(ChatListError(e.toString()));
      }
    });
  }
}
