import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:rest_api_with_bloc/model/photo_model.dart';
import 'package:rest_api_with_bloc/repository/photo_repository.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepository photoRepository;
  late List<Photos> listPhotos;
  PhotoBloc({required this.photoRepository}) : super(PhotoInitialState()) {
    on<PhotoFetchEvent>((event, emit) async {
      emit(PhotoLoadingState());
      try {
        listPhotos = await photoRepository.getPostList();
        emit(PhotoLoadedState(photos: listPhotos));
      } on SocketException {
        emit(PhotoListErrorState(error: ('No internet')));
      } on HttpException {
        emit(PhotoListErrorState(error: ('No service')));
      } on FormatException {
        emit(PhotoListErrorState(error: ('No Format exception')));
      } catch (e) {
        // print(e.toString());
        emit(PhotoListErrorState(error: ('Unknown error occured')));
      }
    });
  }
}
