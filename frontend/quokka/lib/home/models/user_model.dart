import 'package:quokka/home/models/user_post_model.dart';

import 'bloc_model.dart';
import 'comment_model.dart';
import 'follow_model.dart';
import 'like_model.dart';
import 'message_model.dart';

class UserModel {
  final String id;
  final String email;
  final String username;
  final String? bio;
  final String? profileImage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Follow> followers;
  final List<Follow> following;
  final List<UserPostModel> posts;
  final List<Block> blocking;
  final List<Comment> comments;
  final List<Like> likes;
  final List<Message> messages;
  final List<dynamic> reels;
  final List<dynamic> share;
  final List<dynamic> stories;
  final List<dynamic> storyView;
  final List<dynamic> blockedBy;
  final List<dynamic> messageLike;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    this.bio,
    this.profileImage,
    required this.createdAt,
    required this.updatedAt,
    required this.followers,
    required this.following,
    required this.posts,
    required this.blocking,
    required this.comments,
    required this.likes,
    required this.messages,
    required this.reels,
    required this.share,
    required this.stories,
    required this.storyView,
    required this.blockedBy,
    required this.messageLike,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      bio: json['bio'],
      profileImage: json['profileImage'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      followers: (json['followers'] as List).map((e) => Follow.fromJson(e)).toList(),
      following: (json['following'] as List).map((e) => Follow.fromJson(e)).toList(),
      posts: (json['posts'] as List).map((e) => UserPostModel.fromJson(e)).toList(),
      blocking: (json['blocking'] as List).map((e) => Block.fromJson(e)).toList(),
      comments: (json['comments'] as List).map((e) => Comment.fromJson(e)).toList(),
      likes: (json['likes'] as List).map((e) => Like.fromJson(e)).toList(),
      messages: (json['messages'] as List).map((e) => Message.fromJson(e)).toList(),
      reels: json['reels'] ?? [],
      share: json['Share'] ?? [],
      stories: json['stories'] ?? [],
      storyView: json['StoryView'] ?? [],
      blockedBy: json['blockedBy'] ?? [],
      messageLike: json['MessageLike'] ?? [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'bio': bio,
      'profileImage': profileImage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'followers': followers.map((e) => e.toJson()).toList(),
      'following': following.map((e) => e.toJson()).toList(),
      'posts': posts.map((e) => e.toJson()).toList(),
      'blocking': blocking.map((e) => e.toJson()).toList(),
      'comments': comments.map((e) => e.toJson()).toList(),
      'likes': likes.map((e) => e.toJson()).toList(),
      'messages': messages.map((e) => e.toJson()).toList(),
      'reels': reels,
      'share': share,
      'stories': stories,
      'storyView': storyView,
      'blockedBy': blockedBy,
      'messageLike': messageLike,
    };
  }
}
