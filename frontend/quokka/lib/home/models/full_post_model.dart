import 'package:quokka/home/models/share_model.dart';

import 'author_model.dart';
import 'comment_model.dart';
import 'like_model.dart';

class Post {
  final String id;
  final String content;
  final String? imageUrl;
  final String? videoUrl;
  final String createdAt;
  final String authorId;
  final Author author;
  final List<Comment> comments;
  final List<Like> likes;
  final List<Share> shares;

  Post({
    required this.id,
    required this.content,
    this.imageUrl,
    this.videoUrl,
    required this.createdAt,
    required this.authorId,
    required this.author,
    required this.comments,
    required this.likes,
    required this.shares,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      createdAt: json['createdAt'],
      authorId: json['authorId'],
      author: Author.fromJson(json['author']),
      comments:
          (json['comments'] as List<dynamic>)
              .map((comment) => Comment.fromJson(comment))
              .toList(),
      likes:
          (json['likes'] as List<dynamic>)
              .map((like) => Like.fromJson(like))
              .toList(),
      shares:
          (json['shares'] as List<dynamic>)
              .map((share) => Share.fromJson(share))
              .toList(),
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
      'author': author.toJson(),
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'likes': likes.map((like) => like.toJson()).toList(),
      'shares': shares.map((share) => share.toJson()).toList(),
    };
  }
}
