import 'package:flutter/material.dart';
import '../repository/youtube_video_repository.dart';
import '../model/video.dart';

class YoutubeVideoProvider extends ChangeNotifier {
  final YoutubeVideoRepository _youtubeVideoRepository =
      YoutubeVideoRepository();
  List<Video>? _video = [];
  List<Video>? get video => _video;

  String _id = '';
  String get id => _id;
  set id(String id) => _id = id;

  loadVideo() async {
    List<Video>? listVideos =
        await _youtubeVideoRepository.loadVideo(id); //예외처리등 후처리를 위해 다른 변수에 담는다.
    //_movies = await _movieRepository.loadMovies(); 예외처리 안할 땐 이렇게해도 됨.
    _video = listVideos;
    notifyListeners();
  }
}
