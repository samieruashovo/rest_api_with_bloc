import 'package:rest_api_with_bloc/api/service.dart';
import 'package:rest_api_with_bloc/model/photo_model.dart';

class PhotoRepository {
  Future<List<Photos>> getPostList() {
    return PhotoService().getPhotos();
  }
}