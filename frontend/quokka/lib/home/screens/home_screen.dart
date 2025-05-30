import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/auth/dio/dio_client.dart';
import 'package:quokka/home/bloc/post_bloc/post_bloc.dart';
import 'package:quokka/home/repository/user_repository.dart';
import 'package:quokka/home/widgets/post_widget.dart';
import 'package:quokka/utils/theme/theme_cubit.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/repository/auth_repository.dart';
import '../repository/post_repository.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  String? userId;

    void setupScrollController(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        context.read<PostBloc>().add(FetchPosts());
      }
    });
  }
  @override
  void initState() {
    super.initState();
    UserRepository().getUserId().then((value) { userId = value;});
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  PostBloc(postRepository: PostRepository(dio: DioClient.dio))
                    ..add(FetchPosts()),
        ),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => AuthBloc(AuthRepository())),
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
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostInitial || state is PostLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PostError) {
              return Center(child: Text(state.message));
            } else if (state is PostLoaded) {
              if (state.posts.isEmpty) {
                return Center(child: Text('No posts found.'));
              }
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.posts.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.posts.length) {
                    final post = state.posts[index];
                    return PostWidget(post: post, userId: userId!);
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
