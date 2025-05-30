import 'package:dio/dio.dart';

import '../models/comment_model.dart';
import '../models/full_post_model.dart';

class PostRepository {
  final Dio dio;

  PostRepository({required this.dio});

  Future<List<Post>> fetchPosts(int page, int limit) async {
    final response = await dio.get(
      '/posts',
      queryParameters: {'page': page, 'limit': limit},
    );

    if (response.statusCode == 200) {
      List data = response.data;
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> likePost(String postId) async {
    try {
      print(postId);
      final response = await dio.post('/posts/like/$postId');
      if (response.statusCode == 200) {
        print('Post liked successfully');
      } else {
        print('Failed to like post');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Comment>> getComments(String postId) async {
    final response = await dio.get('/posts/comments/$postId');
    try {
      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((json) => Comment.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load comments');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addComment(String id, String comment) async {
    try {
      final response = await dio.post(
        '/posts/comment/$id',
        data: {'content': comment},
      );
      if (response.statusCode == 201) {
        print('Comment added successfully');
      } else {
        print('Failed to add comment');
      }
    } catch (e) {
      print(e);
    }
  }
}
