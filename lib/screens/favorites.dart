import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_youtube_bloc_pattern/blocs/favorite_bloc.dart';
import 'package:flutter_youtube_bloc_pattern/models/video.dart';
import 'package:flutter_youtube_bloc_pattern/screens/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos", style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
          initialData: const {},
          stream: bloc.outFav,
          builder: (context, snapshot){
            return ListView(
              children: snapshot.data!.values.map((v){
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => VideoPlayer(video: v),)
                    );



                  },
                  onLongPress: (){
                    bloc.toggleFavorite(v);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 50,
                        child: Image.network(v.thumb),
                      ),
                      Expanded(
                          child: Text(
                            v.title, style:  TextStyle(color: Colors.white70),
                            maxLines: 2,
                          ),
                      ),
                    ],
                  ),
                );

              }).toList(),
            );
          }
      ),
    );
  }
}
