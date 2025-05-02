import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/auth/dio/dio_client.dart';
import 'package:quokka/utils/theme/theme_cubit.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/repository/auth_repository.dart';
import '../../auth/screens/login_screen.dart';
import '../cubit/home_posts_cubit/home_posts_cubit.dart';
import '../repository/post_repository.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  HomeScreen({super.key});

  void setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        context.read<HomePostsCubit>().fetchPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
          HomePostsCubit(postRepository: PostRepository(dio: DioClient.dio))
            ..fetchPosts(),
        ),
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider(
          create: (_) => AuthBloc(AuthRepository()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(LogoutRequested());
              },
            ),
          ],
        ),
        body: BlocBuilder<HomePostsCubit, HomePostsState>(
          builder: (context, state) {
            if (state is HomePostsInitial ||
                state is HomePostsLoading && state is! HomePostsLoaded) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomePostsError) {
              return Center(child: Text(state.message));
            } else if (state is HomePostsLoaded) {
              if (state.posts.isEmpty) {
                return Center(child: Text('No posts found.'));
              }

              return ListView.builder(
                controller: _scrollController,
                itemCount: state.posts.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.posts.length) {
                    final post = state.posts[index];
                    return ListTile(
                      title: Text(post.content),
                      subtitle:
                          post.imageUrl!.isEmpty
                              ? Image.network(post.imageUrl!)
                              : null,
                    );
                  } else {
                    return Center(child: Text('No more posts.'));
                  }
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
