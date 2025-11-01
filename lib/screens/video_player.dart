import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_youtube_bloc_pattern/blocs/favorite_bloc.dart';
import 'package:flutter_youtube_bloc_pattern/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatelessWidget {
  const VideoPlayer({super.key, required this.video});

  final Video video;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);
    final _youtubeController = YoutubePlayerController(
      initialVideoId: video.id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: false,
        enableCaption: false,
        loop: false,
      ),
    );

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubeController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.white70,
        ),
        aspectRatio: 16.0 / 9.0,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _youtubeController.metadata.title,
              style: const TextStyle(color: Colors.white70),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
      builder: (context, player) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: SizedBox(
            height: 25,
            child: Image.asset("images/logo_youtube.png"),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.black87,
          actions: [
            StreamBuilder<Map<String, Video>>(
              stream: bloc.outFav,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return IconButton(
                    onPressed: () {
                      bloc.toggleFavorite(video);
                    },
                    icon: Icon(
                      snapshot.data!.containsKey(video.id)
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.white,
                    ),
                    iconSize: 25,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            player,
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 10,),
                    Text(
                        video.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      maxLines: 2,
                    ),
                    const Divider(color: Colors.white, height: 20,),
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 20,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10,),
                        Text(
                          video.channel,
                          style: const TextStyle(fontSize: 13, color: Colors.white),
                          maxLines: 2,
                        ),
                      ],
                    )
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}
