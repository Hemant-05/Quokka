import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quokka/auth/dio/dio_client.dart';
import '../../models/comment_model.dart';
import '../../models/full_post_model.dart';
import '../../repository/post_repository.dart';

part '../post_bloc/post_event.dart';

part '../post_bloc/post_state.dart';

//
class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  int page = 1;
  final int limit = 10;
  List<Post> _posts = [];

  PostBloc({required this.postRepository}) : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<LikePost>(_onLikePost);
    on<CommentPost>(_onCommentPost);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    if (state is PostLoading) return;

    final currentState = state;
    List<Post> oldPosts = [];
    if (currentState is PostLoaded) {
      oldPosts = currentState.posts;
      _posts.clear();
      _posts = oldPosts;
    }

    emit(PostLoading());

    try {
      final newPosts = await postRepository.fetchPosts(page, limit);
      final posts = oldPosts + newPosts;
      final hasReachedMax = newPosts.length < limit;
      _posts = posts;
      emit(PostLoaded(posts: posts, hasReachedMax: hasReachedMax));
      if (!hasReachedMax) page++;
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  Future<void> _onLikePost(LikePost event, Emitter<PostState> emit) async {
    postRepository.likePost(event.postId);
    emit(PostLoaded(posts: _posts, hasReachedMax: false));
  }

  Future<void> _onCommentPost(
    CommentPost event,
    Emitter<PostState> emit,
  ) async {
    postRepository.addComment(event.postId, event.comment);
    emit(PostLoaded(posts: _posts, hasReachedMax: false));
  }

  Future<List<Comment>> _onGetCommentPost(
    CommentPost event,
    Emitter<PostState> emit,
  ) async {
    final updatedComments = postRepository.getComments(event.postId);
    return updatedComments;
  }
}
