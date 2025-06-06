import 'package:quokka/home/models/share_model.dart';
import 'package:quokka/home/models/story_view_model.dart';
import 'author_model.dart';
import 'comment_model.dart';
import 'like_model.dart';

class Story {
  final String id;
  final String mediaUrl;
  final String? caption;
  final DateTime createdAt;
  final DateTime expiresAt;
  final String authorId;
  final Author author;
  final List<StoryView> storyViews;
  final List<Share> shares;
  final List<Like> likes;
  final List<Comment> comments;

  Story({
    required this.author,
    required this.storyViews,
    required this.shares,
    required this.likes,
    required this.comments,
    required this.id,
    required this.mediaUrl,
    required this.caption,
    required this.createdAt,
    required this.expiresAt,
    required this.authorId,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      mediaUrl: json['mediaUrl'],
      caption: json['caption'],
      createdAt: DateTime.parse(json['createdAt']),
      expiresAt: DateTime.parse(json['expiresAt']),
      authorId: json['authorId'],
      author: Author.fromJson(json['author']),
      storyViews:
          (json['storyViews'])
              .map((storyView) => StoryView.fromJson(storyView))
              .toList(),
      shares: (json['shares']).map((share) => Share.fromJson(share)).toList(),
      likes: (json['likes']).map((like) => Like.fromJson(like)).toList(),
      comments:
          (json['comments'])
              .map((comment) => Comment.fromJson(comment))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mediaUrl': mediaUrl,
      'caption': caption,
      'createdAt': createdAt.toIso8601String(),
      'expiresAt': expiresAt.toIso8601String(),
      'authorId': authorId,
      'author': author.toJson(),
      'storyViews': storyViews.map((storyView) => storyView.toJson()).toList(),
      'shares': shares.map((share) => share.toJson()).toList(),
      'likes': likes.map((like) => like.toJson()).toList(),
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }
}
