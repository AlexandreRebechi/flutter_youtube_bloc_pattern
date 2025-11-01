import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_youtube_bloc_pattern/api.dart';
import 'package:flutter_youtube_bloc_pattern/models/video.dart';

class VideoBloc implements Cubit {
  late Api api;

  List<Video> videos = [];

  final StreamController _videosController =
      StreamController<List<Video>>.broadcast();

  Stream get outVideos => _videosController.stream;

  final StreamController _searchController = StreamController<String>();

  Sink get inSearch => _searchController.sink;

  VideoBloc() {
    api = Api();
    _searchController.stream.listen(_search);
  }

  void _search(dynamic search) async {
    if (search.isNotEmpty) {
      _videosController.sink.add(<Video>[]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }

    _videosController.sink.add(videos);
    print(videos);
  }

  @override
  Future<void> close() async {
    _videosController.close();
    _searchController.close();
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {}

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
  Stream get stream => outVideos;
}
