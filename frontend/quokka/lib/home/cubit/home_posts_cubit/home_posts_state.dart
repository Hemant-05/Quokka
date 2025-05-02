part of '../home_posts_cubit/home_posts_cubit.dart';

abstract class HomePostsState {}

class HomePostsInitial extends HomePostsState {}

class HomePostsLoading extends HomePostsState {}

class HomePostsLoaded extends HomePostsState {
  final List<Post> posts;
  HomePostsLoaded({required this.posts});
}

class HomePostsError extends HomePostsState {
  final String message;
  HomePostsError({required this.message});
}
