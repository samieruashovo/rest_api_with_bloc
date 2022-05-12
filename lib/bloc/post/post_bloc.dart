import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rest_api_with_bloc/model/post_model.dart';
import 'package:rest_api_with_bloc/repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  late List<Post> listPost;
  PostBloc({required this.postRepository}) : super(PostInitialState()) {
    on<PostFetchEvent>((event, emit) async {
      emit(PostLoadingState());
      try {
        listPost = await postRepository.getPostList();
        emit(PostLoadedState(post: listPost));
      } on SocketException {
        emit(PostListErrorState(error: ('No internet')));
      } on HttpException {
        emit(PostListErrorState(error: ('No service')));
      } on FormatException {
        emit(PostListErrorState(error: ('No Format exception')));
      } catch (e) {
        print(e.toString());
        emit(PostListErrorState(error: ('Unknown error occured')));
      }
    });
  }
}
