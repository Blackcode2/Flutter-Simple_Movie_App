import 'package:flutter/material.dart';
import 'package:simple_movie/repository/trending_repository.dart';
import '../model/movie.dart';

class TrendingProvider extends ChangeNotifier {
  final TrendingRepository _trendingRepository = TrendingRepository();
  List<Movie>? _movies = [];
  List<Movie>? get movies => _movies;

  loadMovies() async {
    List<Movie>? listMovies =
        await _trendingRepository.loadMovies(); //예외처리등 후처리를 위해 다른 변수에 담는다.
    //_movies = await _movieRepository.loadMovies(); 예외처리 안할 땐 이렇게해도 됨.
    _movies = listMovies;
    notifyListeners();
  }
}
