import 'package:quokka/home/models/author_model.dart';
import 'package:quokka/home/models/share_model.dart';
import 'comment_model.dart';
import 'like_model.dart';

class Reel {
  final String id;
  final String videoUrl;
  final String? caption;
  final Author author;
  final String authorId;
  final DateTime createdAt;
  final List<Like> likes;
  final List<Comment> comments;
  final List<Share> shares;

  Reel({
    required this.author,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.id,
    required this.videoUrl,
    required this.caption,
    required this.authorId,
    required this.createdAt,
  });

  factory Reel.fromJson(Map<String, dynamic> json) {
    return Reel(
      id: json['id'],
      videoUrl: json['videoUrl'],
      caption: json['caption'],
      authorId: json['authorId'],
      createdAt: DateTime.parse(json['createdAt']),
      author: Author.fromJson(json['author']),
      likes:
          (json['likes'])
              .map((like) => Like.fromJson(like))
              .toList(),
      comments:
          (json['comments'])
              .map((comment) => Comment.fromJson(comment))
              .toList(),
      shares: (json['shares']).map((share) => Share.fromJson(share)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'videoUrl': videoUrl,
      'caption': caption,
      'authorId': authorId,
      'createdAt': createdAt.toIso8601String(),
      'author': author.toJson(),
      'likes': likes.map((like) => like.toJson()).toList(),
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'shares': shares.map((share) => share.toJson()).toList(),
    };
  }
}
