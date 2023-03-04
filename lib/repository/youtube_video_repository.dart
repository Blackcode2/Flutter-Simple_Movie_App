import 'dart:convert';
import '../model/video.dart';
import 'package:http/http.dart' as http;

class YoutubeVideoRepository {
  // var queryPram = {
  //   'api_key' : '',
  //   'query' : 'avatar'
  // };
  final String apiKey = '';

  Future<List<Video>?> loadVideo(String id) async {
    // var url =
    // Uri.https('api.themoviedb.org', '3/search/movie', queryPram);
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=$apiKey');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      List<dynamic> list = body['results'];
      return list.map<Video>((item) => Video.fromJson(item)).toList();
    }
    return null;
  }
}
