part of '../post_bloc/post_bloc.dart';

abstract class PostEvent {}

class FetchPosts extends PostEvent {}

class LikePost extends PostEvent {
  final String postId;
  LikePost(this.postId);
}

class CommentPost extends PostEvent {
  final String postId;
  final String comment;
  CommentPost(this.postId, this.comment);
}