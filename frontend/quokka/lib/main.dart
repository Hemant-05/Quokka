import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/auth/screens/splash_screen.dart';
import 'package:quokka/home/bloc/chat_list_bloc/chat_list_bloc.dart';
import 'package:quokka/home/bloc/post_bloc/post_bloc.dart';
import 'package:quokka/home/repository/user_repository.dart';
import 'package:quokka/home/socketIO/socket_io_connection.dart';
import 'package:quokka/utils/theme/theme.dart';
import 'package:quokka/utils/theme/theme_cubit.dart';
import 'package:socket_io_client/src/socket.dart';
import 'auth/bloc/auth_bloc.dart';
import 'auth/repository/auth_repository.dart';
import 'auth/dio/dio_client.dart';
import 'home/bloc/chat_bloc/chat_bloc.dart';
import 'home/repository/chat_repository.dart';
import 'home/repository/post_repository.dart';

var userId = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioClient.init();
  runApp(const QuokkaApp());
  userId = await UserRepository().getUserId();
}

class QuokkaApp extends StatelessWidget {
  const QuokkaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()..loadTheme()),
        BlocProvider(create: (_) => AuthBloc(AuthRepository())),
        BlocProvider(
          create:
              (_) => ChatBloc(
                ChatSocketManager().createSocket(userId: userId)
              ),
        ),
        BlocProvider(
          create:
              (_) =>
                  PostBloc(postRepository: PostRepository(dio: DioClient.dio)),
        ),
        BlocProvider(
          create: (_) => ChatListBloc(ChatRepository(DioClient.dio)),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Quokka Social',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
