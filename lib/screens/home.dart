import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_youtube_bloc_pattern/blocs/favorite_bloc.dart';
import 'package:flutter_youtube_bloc_pattern/blocs/videos_bloc.dart';
import 'package:flutter_youtube_bloc_pattern/delegates/data_search.dart';
import 'package:flutter_youtube_bloc_pattern/screens/favorites.dart';
import 'package:flutter_youtube_bloc_pattern/widgets/video_tile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final blocV = BlocProvider.of<VideoBloc>(context);
    final blocF = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 30,
          child: Image.asset('images/logo_youtube.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: blocF.outFav,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Text(
                    "${snapshot.data!.length}",
                    style: TextStyle(color: Colors.white),
                  );
                else
                  return Container();
              },
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => Favorites()));
            },
            icon: Icon(Icons.star, color: Colors.white),
          ),
          IconButton(
            onPressed: () async {
              final result = await showSearch(
                context: context,
                delegate: DataSearch(),
              );
              if (result != null) {
                blocV.inSearch.add(result);
              }
            },
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder(
        stream: blocV.outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index < snapshot.data!.length) {
                  return VideoTile(video: snapshot.data[index]);
                } else if (index > 1) {
                  blocV.inSearch.add('');
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                }
                return Container();
              },
              itemCount: snapshot.data!.length + 1,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
