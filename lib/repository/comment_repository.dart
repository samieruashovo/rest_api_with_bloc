import 'package:rest_api_with_bloc/api/service.dart';
import 'package:rest_api_with_bloc/model/comment_model.dart';

class CommentRepository {
  Future<List<Comment>> getCommentList() {
    return CommentService().getComment();
  }
}
