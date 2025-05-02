import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/full_post_model.dart';
import '../../repository/post_repository.dart';
part '../home_posts_cubit/home_posts_state.dart';

class HomePostsCubit extends Cubit<HomePostsState> {
  final PostRepository postRepository;
  int page = 1;
  bool hasMore = true;

  HomePostsCubit({required this.postRepository}) : super(HomePostsInitial());

  Future<void> fetchPosts({bool isRefresh = false}) async {
    if (state is HomePostsLoading) return;

    try {
      if (isRefresh) {
        page = 1;
        hasMore = true;
        emit(HomePostsInitial());
      }

      emit(HomePostsLoading());

      final posts = await postRepository.fetchPosts(page,10);

      if (posts.isEmpty) {
        hasMore = false;
      } else {
        page++;
      }

      emit(HomePostsLoaded(posts: [...(state is HomePostsLoaded ? (state as HomePostsLoaded).posts : []), ...posts]));
    } catch (e) {
      emit(HomePostsError(message: e.toString()));
    }
  }
}
