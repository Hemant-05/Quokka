import 'package:flutter/material.dart';
import 'package:quokka/auth/dio/dio_client.dart';

import '../repository/chat_repository.dart';

class ChatRoomScreen extends StatefulWidget {
  final String chatId;
  ChatRoomScreen({required this.chatId});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _controller = TextEditingController();
  late final ChatRepository repository;

  @override
  void initState() {
    super.initState();
    repository = ChatRepository(DioClient.dio);
    // Initialize socket connection and message stream here
  }

  void sendMessage() async {
    if (_controller.text.trim().isNotEmpty) {
      await repository.sendMessage(widget.chatId, _controller.text);
      _controller.clear();
      // Refresh messages
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fetch messages and display with ListView
    return Scaffold(
      appBar: AppBar(title: Text("Chat Room")),
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(controller: _controller),
              ),
              IconButton(onPressed: sendMessage, icon: Icon(Icons.send))
            ],
          )
        ],
      ),
    );
  }
}
