part of 'post_bloc.dart';

@immutable
abstract class PostState {
}

class PostLoadingState extends PostState {}

class PostInitialState extends PostState {}

class PostLoadedState extends PostState {
  final List<Post> post;

  PostLoadedState({required this.post});
}

class PostListErrorState extends PostState {
  final error;

  PostListErrorState({required this.error});
}
