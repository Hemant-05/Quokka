import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'home_screen.dart';
import 'reels_screen.dart';
import 'chats_list_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> _screens = [
    HomeScreen(),
    ReelsScreen(),
    SearchScreen(),
    ChatListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return Scaffold(
            body: _screens[state],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state,
              onTap: (index) => context.read<BottomNavCubit>().updateIndex(index),
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.play_arrow), label: "Reels"),
                BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
              ],
            ),
          );
        },
      ),
    );
  }
}
