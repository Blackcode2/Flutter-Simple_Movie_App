import 'package:flutter/material.dart';
import 'package:simple_movie/model/video.dart';
import 'package:simple_movie/ui/youtube_video_player_screen.dart';
import '../model/movie.dart';
import 'package:provider/provider.dart';
import '../controller/youtube_video_provider.dart';

class DetailPage extends StatelessWidget {
  Movie movie;
  late YoutubeVideoProvider _youtubeVideoProvider;
  DetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _youtubeVideoProvider =
        Provider.of<YoutubeVideoProvider>(context, listen: false);
    Future<void> loadVideo() async {
      _youtubeVideoProvider.id = movie.id.toString();
      await _youtubeVideoProvider.loadVideo();
    }

    List<Video>? preVideo = _youtubeVideoProvider.video;
    loadVideo();
    if (_youtubeVideoProvider.video!.isEmpty ||
        _youtubeVideoProvider.video == null) {
      loadVideo();
    } else if (preVideo == _youtubeVideoProvider.video) {
      loadVideo();
    }
    String key = _youtubeVideoProvider.video![0].key!;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: YoutubeVideoPlayer(
                videoID: key,
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: size.width * 0.6,
                              child: Text(
                                movie.title!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: const [
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                      color: Colors.white70,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(15.0),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         'Release Date: ${movie.releaseDate!}',
                    //         style: TextStyle(
                    //           fontSize: 16
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Divider(
                    //   height: 1,
                    //   thickness: 1,
                    //   indent: 10,
                    //   endIndent: 10,
                    //   color: Colors.white70,
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                      child: Text(
                        movie.overview!,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
