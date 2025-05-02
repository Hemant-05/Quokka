import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/auth/dio/dio_client.dart';
import '../bloc/chat_bloc/chat_list_bloc.dart';
import '../repository/chat_repository.dart';
import 'chat_room_screen.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatListBloc(ChatRepository(DioClient.dio))..add(LoadChatList()),
      child: Scaffold(
        appBar: AppBar(title: Text("Chats")),
        body: BlocBuilder<ChatListBloc, ChatListState>(
          builder: (context, state) {
            if (state is ChatListLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ChatListLoaded) {
              return ListView.builder(
                itemCount: state.chats.length,
                itemBuilder: (_, i) {
                  final chat = state.chats[i];
                  return ListTile(
                    title: Text(chat.name!),
                    subtitle: Text(chat.lastMessage?.content ?? "No messages"),
                    trailing: chat.unseenCount! > 0
                        ? CircleAvatar(radius: 10, child: Text(chat.unseenCount.toString()))
                        : null,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (_) => ChatRoomScreen(chatId: chat.id),
                      ));
                    },
                  );
                },
              );
            } else {
              return Center(child: Text("Failed to load chats"));
            }
          },
        ),
      ),
    );
  }
}
