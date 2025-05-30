import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/home/models/chat_model.dart';
import 'package:quokka/home/models/user_model.dart';
import 'package:quokka/home/socketIO/socket_io_connection.dart';
import '../bloc/chat_bloc/chat_bloc.dart';
import '../models/message_model.dart';
import '../widgets/chat_message_bubble.dart';

class ChatRoomScreen extends StatefulWidget {
  final Chat chat;
  final UserModel model;

  const ChatRoomScreen({super.key, required this.chat, required this.model});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final ChatBloc chatBloc;
  void send() {
    if (_messageController.text.trim().isNotEmpty) {
      context.read<ChatBloc>().add(
        SendMessageEvent(
          _messageController.text.trim(),
          widget.chat.id,
          widget.model.id,
        ),
      );
      _messageController.clear();
      Future.delayed(Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }
@override
  void initState() {
    super.initState();
    chatBloc = context.read<ChatBloc>();
  }
  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    chatBloc.add(LeaveChatRoom(widget.chat.id));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socket = ChatSocketManager().createSocket(userId: widget.model.id);
    return BlocProvider(
      create:
          (context) =>
              ChatBloc(socket)
                ..add(JoinChatRoom(widget.chat.id))
                ..add(LoadChatMessagesEvent(widget.chat.id)),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          List<Message> messages = [];
          if (state is ChatLoaded) {
            messages = state.messages;
          }
          return Scaffold(
            appBar: AppBar(title: Text(widget.chat.name!)),
            body:
                state is ChatLoading
                    ? Center(child: CircularProgressIndicator())
                    : state is ChatLoaded
                    ? Column(
                      children: [
                        Expanded(
                          child:
                              messages.isNotEmpty
                                  ? ListView.builder(
                                    controller: _scrollController,
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      final message = messages[index];
                                      final isSender =
                                          message.senderId == widget.model.id;
                                      return ChatMessageBubble(
                                        message: message,
                                        isSender: isSender,
                                      );
                                    },
                                  )
                                  : Center(child: Text("Start Chatting.....")),
                        ),
                        Divider(height: 1),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _messageController,
                                  decoration: InputDecoration(
                                    hintText: "Type a message...",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.blueAccent,
                                ),
                                onPressed: send,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                    : state is ChatError
                    ? Center(child: Text("Some error occured"))
                    : Container(),
          );
        },
      ),
    );
  }
}
