import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/auth/screens/splash_screen.dart';
import 'package:quokka/utils/theme/theme.dart';
import 'package:quokka/utils/theme/theme_cubit.dart';
import 'auth/bloc/auth_bloc.dart';
import 'auth/repository/auth_repository.dart';
import 'auth/dio/dio_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioClient.init();
  runApp(const QuokkaApp());
}

class QuokkaApp extends StatelessWidget {
  const QuokkaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()..loadTheme()),
        BlocProvider(create: (_) => AuthBloc(AuthRepository())),
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