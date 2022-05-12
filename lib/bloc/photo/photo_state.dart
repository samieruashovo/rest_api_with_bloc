part of 'photo_bloc.dart';

abstract class PhotoState{
}

class PhotoInitialState extends PhotoState {}
class PhotoLoadingState extends PhotoState{}
class PhotoLoadedState extends PhotoState{
  final List<Photos> photos;

  PhotoLoadedState({required this.photos});
  
}
class PhotoListErrorState extends PhotoState{
  final error;

  PhotoListErrorState({required this.error});
  
}

