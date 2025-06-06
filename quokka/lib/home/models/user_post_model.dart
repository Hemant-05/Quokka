import 'package:quokka/home/models/share_model.dart';

import 'author_model.dart';
import 'comment_model.dart';
import 'like_model.dart';

class UserPostModel {
  final String id;
  final String content;
  final String? imageUrl;
  final String? videoUrl;
  final String createdAt;
  final String authorId;

  UserPostModel({
    required this.id,
    required this.content,
    this.imageUrl,
    this.videoUrl,
    required this.createdAt,
    required this.authorId,
  });

  factory UserPostModel.fromJson(Map<String, dynamic> json) {
    return UserPostModel(
      id: json['id'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      createdAt: json['createdAt'],
      authorId: json['authorId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'createdAt': createdAt,
      'authorId': authorId,
    };
  }
}
