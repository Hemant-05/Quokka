import 'package:dio/dio.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRepository {
  final Dio dio;
  ChatRepository(this.dio);

  Future<List<Chat>> getUserChats() async {
    final res = await dio.get('/chats');
    return (res.data as List).map((e) => Chat.fromJson(e)).toList();
  }

  Future<List<Message>> getChatMessages(String chatId) async {
    final res = await dio.get('/chats/$chatId/messages');
    return (res.data as List).map((e) => Message.fromJson(e)).toList();
  }

  Future<void> sendMessage(String chatId, String content) async {
    await dio.post('/chats/$chatId/messages', data: {'content': content});
  }

  Future<void> markMessagesAsSeen(String chatId) async {
    await dio.post('/chats/$chatId/seen');
  }
}
