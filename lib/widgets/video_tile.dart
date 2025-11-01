import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_youtube_bloc_pattern/blocs/favorite_bloc.dart';
import 'package:flutter_youtube_bloc_pattern/models/video.dart';
import 'package:flutter_youtube_bloc_pattern/screens/video_player.dart';

class VideoTile extends StatelessWidget {
  const VideoTile({super.key, required this.video});

  final Video video;

  @override
  Widget build(BuildContext context) {

    final bloc  =BlocProvider.of<FavoriteBloc>(context);

    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => VideoPlayer(video: video),
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Image.network(video.thumb, fit: BoxFit.cover),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsetsGeometry.fromSTEB(8, 8, 8, 0),
                        child: Text(
                          video.title,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          video.channel,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                  stream: bloc.outFav,
                  initialData: {},
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.hasData) {
                      return IconButton(
                        onPressed: () {
                          bloc.toggleFavorite(video);
                        },
                        color: Colors.white,
                        iconSize: 30,
                        icon: Icon(asyncSnapshot.data!.containsKey(video.id) ? Icons.star :  Icons.star_border),
                      );
                    } else
                      return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
