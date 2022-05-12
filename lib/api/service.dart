import 'package:http/http.dart' as http;
import 'package:rest_api_with_bloc/model/comment_model.dart';
import 'package:rest_api_with_bloc/model/photo_model.dart';
import 'package:rest_api_with_bloc/model/post_model.dart';

abstract class ServiecApi {
  // Future<List<Post>> getPost();
}

class PostService extends ServiecApi {
  //String baseUrl = "https://jsonplaceholder.typicode.com";
  // String posts = "/posts";
  // String comments = "/comments";
  Future<List<Post>> getPost() async {
    var uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var response = await http.Client().get(uri);
    if (response.statusCode == 200) {
      return postFromJson(response.body);
    } else {
      return List<Post>.empty();
    }
  }
}

class CommentService extends ServiecApi {
  Future<List<Comment>> getComment() async {
    var uri = Uri.parse("https://jsonplaceholder.typicode.com/comments");
    var response = await http.Client().get(uri);
    if (response.statusCode == 200) {
      return commentFromJson(response.body);
    } else {
      return List<Comment>.empty();
    }
  }
}

class PhotoService extends ServiecApi {
  Future<List<Photos>> getPhotos() async {
    var uri = Uri.parse("https://jsonplaceholder.typicode.com/photos");
    var response = await http.Client().get(uri);
    if (response.statusCode == 200) {
      return photosFromJson(response.body);
    } else {
      return List<Photos>.empty();
    }
  }
}
