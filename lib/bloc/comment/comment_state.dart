part of 'comment_bloc.dart';

abstract class CommentState {}

class CommentLoadingState extends CommentState {}

class CommentInitialState extends CommentState {}

class CommentLoadedState extends CommentState {
  final List<Comment> comment;

  CommentLoadedState({required this.comment});
}

class CommentListErrorState extends CommentState {
  final error;

  CommentListErrorState({required this.error});
}
