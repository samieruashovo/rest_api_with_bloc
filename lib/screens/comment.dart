import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_with_bloc/bloc/comment/comment_bloc.dart';
import 'package:rest_api_with_bloc/model/comment_model.dart';

class CommentView extends StatefulWidget {
  final bool isDark;
  const CommentView({Key? key, required this.isDark}) : super(key: key);

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  @override
  void initState() {
    super.initState();
    loadComment();
  }

  loadComment() async {
    context.read<CommentBloc>().add(CommentFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: BlocBuilder<CommentBloc, CommentState> (builder: (BuildContext context, CommentState state){
        if(state is CommentListErrorState){
          final error = state.error;
          String message = '${error.message}\nTap to Retry.';
          return Text(
            message,
          );
        }
        if(state is CommentLoadedState){
          List<Comment> comments = state.comment;
          return _list(comments);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
  Widget _list(List<Comment> comments){
    return  ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comments[index].name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        comments[index].body,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ));
            });
  }
}
