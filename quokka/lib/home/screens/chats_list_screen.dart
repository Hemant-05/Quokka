import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/auth/dio/dio_client.dart';
import 'package:quokka/home/models/user_model.dart';
import 'package:quokka/home/repository/user_repository.dart';
import 'package:quokka/home/socketIO/socket_io_connection.dart';
import '../bloc/chat_list_bloc/chat_list_bloc.dart';
import '../repository/chat_repository.dart';
import 'chat_room_screen.dart';

class ChatListScreen extends StatefulWidget {
  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final int? unseenCount = 10;
  String userId = "1";
  UserModel? model;

  @override
  void initState(){
    getModel();
    super.initState();
  }

  void getModel() async {
    model = await UserRepository().getUserFromPrefs();
    userId = model!.id;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatListBloc(ChatRepository(DioClient.dio))..add(LoadUserChats(userId)),
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
                    trailing: unseenCount! > 0
                        ? CircleAvatar(radius: 10, child: Text(unseenCount.toString()))
                        : null,
                    onTap: () {
                      // ChatSocketService().connectSocket(model!.id,chat.id);
                      Navigator.push(context, MaterialPageRoute(
                        builder: (_) => ChatRoomScreen(chat: chat,model: model!,),
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
