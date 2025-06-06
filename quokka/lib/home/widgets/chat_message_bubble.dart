import 'package:flutter/material.dart';
import 'package:quokka/home/models/user_model.dart';
import '../models/message_model.dart';

class ChatMessageBubble extends StatelessWidget {
  final Message message;
  final UserModel? model;
  final bool isSender;

  const ChatMessageBubble({
    super.key,
    required this.message, this.model, required this.isSender
  });


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        decoration: BoxDecoration(
          color: isSender ? Colors.deepPurpleAccent : Colors.grey.shade200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isSender ? 12 : 0),
            bottomRight: Radius.circular(isSender ? 0 : 12),
          ),
        ),
        child: Text(
          message.content!,
          style: TextStyle(
            color: isSender ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
