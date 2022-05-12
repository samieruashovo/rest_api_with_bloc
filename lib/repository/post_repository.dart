import 'package:rest_api_with_bloc/api/service.dart';
import 'package:rest_api_with_bloc/model/post_model.dart';

class PostRepository {
  Future<List<Post>> getPostList() {
    return PostService().getPost();
  }
}
