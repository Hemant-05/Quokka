part of '../post_bloc/post_bloc.dart';


abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  PostLoaded({required this.posts, required this.hasReachedMax});
}

class PostError extends PostState {
  final String message;

  PostError({required this.message});
}
