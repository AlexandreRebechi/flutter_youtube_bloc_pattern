import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_youtube_bloc_pattern/api.dart';
import 'package:flutter_youtube_bloc_pattern/blocs/favorite_bloc.dart';
import 'package:flutter_youtube_bloc_pattern/blocs/videos_bloc.dart';
import 'package:flutter_youtube_bloc_pattern/screens/home.dart';

void main() {
  Api api = Api();
  api.search("eletro");

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //final bloc = BlocProvider.of<VideoBloc>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<VideoBloc>(
            create: (_) => VideoBloc()),
        BlocProvider<FavoriteBloc>(
            create: (_) => FavoriteBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Youtube BLoC Parttern',
        home: Home(),
      ),
    );
  }
}
