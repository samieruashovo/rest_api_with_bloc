import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:rest_api_with_bloc/model/comment_model.dart';
import 'package:rest_api_with_bloc/repository/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;
  late List<Comment> listComment;
  CommentBloc({required this.commentRepository}) : super(CommentInitialState()) {
    on<CommentFetchEvent>((event, emit) async {
     emit(CommentLoadingState());
     try{
       listComment = await commentRepository.getCommentList();
       emit(CommentLoadedState(comment: listComment));
     }on SocketException {
        emit(CommentListErrorState(error: ('No internet')));
      } on HttpException {
        emit(CommentListErrorState(error: ('No service')));
      } on FormatException {
        emit(CommentListErrorState(error: ('No Format exception')));
      } catch (e) {
       // print(e.toString());
        emit(CommentListErrorState(error: ('Unknown error occured')));
      }
    });
  }
}
