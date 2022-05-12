import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_with_bloc/bloc/comment/comment_bloc.dart';
import 'package:rest_api_with_bloc/bloc/photo/photo_bloc.dart';
import 'package:rest_api_with_bloc/bloc/post/post_bloc.dart';
import 'package:rest_api_with_bloc/bloc/theme/theme_bloc.dart';
import 'package:rest_api_with_bloc/repository/comment_repository.dart';
import 'package:rest_api_with_bloc/repository/photo_repository.dart';
import 'package:rest_api_with_bloc/repository/post_repository.dart';
import 'package:rest_api_with_bloc/screens/post.dart';

void main() {
  runApp(const RestApiWithBloc());
}

class RestApiWithBloc extends StatefulWidget {
  const RestApiWithBloc({Key? key}) : super(key: key);

  @override
  State<RestApiWithBloc> createState() => _RestApiWithBlocState();
}

class _RestApiWithBlocState extends State<RestApiWithBloc> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, PostThemeState>(
        builder: (BuildContext context, PostThemeState themestate) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      PostBloc(postRepository: PostRepository())),
              BlocProvider(
                  create: (context) =>
                      CommentBloc(commentRepository: CommentRepository())),
              BlocProvider(
                  create: (context) =>
                      PhotoBloc(photoRepository: PhotoRepository())),
            ],
            child: MaterialApp(
              theme: themestate.themeData,
              home: const PostClass(),
            ),
          );
        },
      ),
    );
  }
}
