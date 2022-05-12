import 'package:flutter/material.dart';
import 'package:rest_api_with_bloc/bloc/post/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_with_bloc/bloc/theme/theme_bloc.dart';
import 'package:rest_api_with_bloc/model/comment_model.dart';
import 'package:rest_api_with_bloc/model/post_model.dart';
import 'package:rest_api_with_bloc/screens/comment.dart';
import 'package:rest_api_with_bloc/screens/photo.dart';
import 'package:rest_api_with_bloc/theme/app_theme.dart';

class PostClass extends StatefulWidget {
  const PostClass({Key? key}) : super(key: key);

  @override
  State<PostClass> createState() => _PostClassState();
}

class _PostClassState extends State<PostClass> {
  bool isDark = true;
  @override
  void initState() {
    super.initState();
    loadPost();
  }

  loadPost() async {
    context.read<PostBloc>().add(PostFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rest Api With Bloc"),
        actions: [
          IconButton(
            icon: isDark
                ? const Icon(Icons.brightness_4)
                : const Icon(Icons.brightness_2),
            onPressed: () {
              _setTheme(isDark);
              isDark == false ? isDark = true : isDark = false;
            },
          ),
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
          builder: (BuildContext context, PostState state) {
        if (state is PostListErrorState) {
          final error = state.error;
          String message = '${error.message}\nTap to Retry.';
          return Text(
            message,
          );
        }
        if (state is PostLoadedState) {
          List<Post> posts = state.post;
          return _list(posts);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  Widget _list(List<Post> posts) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (_, index) {
          Post post = posts[index];
          return Container(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          post.title,
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10,),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CommentView(
                                            isDark: isDark,
                                          )));
                            },
                            icon: Icon(
                              Icons.comment_outlined,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PhotoView(
                                            isDark: isDark,
                                          )));
                            },
                            icon: Icon(
                              Icons.photo_outlined,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    post.body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                  ),
                ),
                Divider(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ],
            ),
          );
        });
  }

  _setTheme(bool darkTheme) async {
    AppTheme selectedTheme =
        darkTheme ? AppTheme.lightTheme : AppTheme.darkTheme;
    context.read<ThemeBloc>().add(PostThemeEvent(appTheme: selectedTheme));
  }
}
