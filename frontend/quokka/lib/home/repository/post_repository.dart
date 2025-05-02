import 'package:dio/dio.dart';

import '../models/full_post_model.dart';

class PostRepository {
  final Dio dio;

  PostRepository({required this.dio});

  Future<List<Post>> fetchPosts(int page, int limit) async {
    final response = await dio.get('/posts', queryParameters: {
      'page': page,
      'limit': limit,
    });

    if (response.statusCode == 200) {
      List data = response.data;
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
