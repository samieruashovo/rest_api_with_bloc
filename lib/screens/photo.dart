import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_with_bloc/bloc/photo/photo_bloc.dart';
import 'package:rest_api_with_bloc/model/photo_model.dart';

class PhotoView extends StatefulWidget {
  final bool isDark;
  const PhotoView({Key? key, required this.isDark}) : super(key: key);

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  @override
  void initState() {
    super.initState();
    loadPhotos();
  }

  loadPhotos() async {
    context.read<PhotoBloc>().add(PhotoFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
      ),
      body: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (BuildContext context, PhotoState state) {
        if (state is PhotoListErrorState) {
          final error = state.error;
          String message = '${error.message}\nTap to Retry.';
          return Text(
            message,
          );
        }
        if (state is PhotoLoadedState) {
          List<Photos> photos = state.photos;
          return _list(photos);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  Widget _list(List<Photos> photos) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(photos[index].title,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyText1!.color,),
                            ),
                            
                            ),
                          Image(
                    image: NetworkImage(photos[index].url),
                  ),
                        ],
                      )),

                  const SizedBox(
                    height: 15,
                  ),
                ],
              ));
        });
  }
}
