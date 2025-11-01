import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_youtube_bloc_pattern/models/video.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc implements Cubit {

  Map<String, Video> _favorites = {};

  final StreamController<Map<String, Video>> _favController = BehaviorSubject<Map<String, Video>>();
  Stream<Map<String, Video>> get outFav => _favController.stream;

  FavoriteBloc(){
    SharedPreferences.getInstance().then((prefs){
      if(prefs.getKeys().contains("favorites")){
        _favorites = json.decode(prefs.getString("favorites")!).map((k, v){
          return MapEntry(k,Video.fromJson(v));
        }).cast<String, Video>();
        _favController.add(_favorites);
      }
    });
  }


  void toggleFavorite(Video video){
    if(_favorites.containsKey(video.id)) _favorites.remove(video.id);
    else _favorites[video.id] = video;

    _favController.sink.add(_favorites);
    
    _saveFav();
  }
  
  void _saveFav(){
    SharedPreferences.getInstance().then((prefs){
      prefs.setString("favorites", json.encode(_favorites));
    });
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    // TODO: implement addError
  }

  @override
  Future<void> close() async{
    _favController.close();
  }

  @override
  void emit(state) {}

  @override
  // TODO: implement isClosed
  bool get isClosed => false;

  @override
  void onChange(Change change) {}

  @override
  void onError(Object error, StackTrace stackTrace) {}

  @override
  // TODO: implement state
  get state => null;

  @override
  // TODO: implement stream
  Stream get stream => outFav;

}