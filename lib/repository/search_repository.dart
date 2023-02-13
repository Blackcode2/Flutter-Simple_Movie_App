import 'dart:convert';
import 'package:simple_movie/model/search.dart';
import 'package:http/http.dart' as http;

class SearchRepository {
  // var queryPram = {
  //   'api_key' : '4a1a1f3fea356867577bbf4461fbc1dc',
  //   'query' : 'avatar'
  // };
  final String apiKey = '4a1a1f3fea356867577bbf4461fbc1dc';

  Future<List<Search>?> loadSearch(String query) async {
    // var url =
    // Uri.https('api.themoviedb.org', '3/search/movie', queryPram);
    var url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      List<dynamic> list = body['results'];
      return list.map<Search>((item) => Search.fromJson(item)).toList();
    }
    return null;
  }
}
