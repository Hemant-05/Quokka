import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/home/bloc/chat_list_bloc/chat_list_bloc.dart';
import 'package:quokka/home/models/message_model.dart';
import 'package:quokka/home/repository/chat_repository.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../auth/dio/dio_client.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final Socket socket;
  List<Message> _messages = [];

  ChatBloc(this.socket) : super(ChatInitial()) {
    on<JoinChatRoom>((event, emit) {
      socket.emit('join-chat', event.chatId);
      socket.on('receive-message', (data) {
        final message = Message.fromJson(data);
        if (!_messages.any((m) => m.id == message.id)) {
          add(ReceiveMessageEvent(message));
        }
      });
    });

    on<LeaveChatRoom>((event, emit) {
      socket.emit('leave-chat', event.chatId);
      socket.off('receive-message');
      socket.off('join-chat');
      _messages.clear();
    });

    on<LoadChatMessagesEvent>((event, emit) async {
      emit(ChatLoading());
      try {
        _messages = await ChatRepository(DioClient.dio).getChatMessages(event.chatId);
        emit(ChatLoaded(_messages));
      } catch (e) {
        emit(ChatError("Failed to load messages"));
      }
    });

    on<SendMessageEvent>((event, emit) {
      final Message message = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: event.message,
        senderId: event.senderId,
        chatId: event.chatId,
        createdAt: DateTime.now(),
      );
      socket.emit('send-message', message);
    });

    on<ReceiveMessageEvent>((event, emit) {
      _messages.add(event.message);
      emit(ChatLoaded(List.from(_messages)));
    });
  }
}
