import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/full_post_model.dart';
import '../../repository/post_repository.dart';
part '../post_bloc/post_event.dart';
part '../post_bloc/post_state.dart';
//
class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  int page = 1;
  final int limit = 10;

  PostBloc({required this.postRepository}) : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    if (state is PostLoading) return;

    final currentState = state;
    List<Post> oldPosts = [];
    if (currentState is PostLoaded) {
      oldPosts = currentState.posts;
    }

    emit(PostLoading());

    try {
      final newPosts = await postRepository.fetchPosts(page, limit);
      final posts = oldPosts + newPosts;
      final hasReachedMax = newPosts.length < limit;
      emit(PostLoaded(posts: posts, hasReachedMax: hasReachedMax));
      if (!hasReachedMax) page++;
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }
}
