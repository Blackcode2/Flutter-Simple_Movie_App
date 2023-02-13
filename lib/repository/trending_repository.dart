import 'dart:convert';
import 'package:simple_movie/model/movie.dart';
import 'package:http/http.dart' as http;

class TrendingRepository{
  var queryPram = {
    'api_key' : '4a1a1f3fea356867577bbf4461fbc1dc'
  };
  Future<List<Movie>?> loadMovies() async{
    var url =
      Uri.https('api.themoviedb.org', '3/trending/all/week', queryPram);

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      List<dynamic> list = body['results'];
      return list.map<Movie>((item) => Movie.fromJson(item)).toList();
    }
    return null;
  }
}