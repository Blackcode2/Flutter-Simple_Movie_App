import 'package:flutter/material.dart';
import 'package:simple_movie/model/video.dart';
import 'package:simple_movie/view/youtube_video_player_screen.dart';
import '../model/movie.dart';
import 'package:provider/provider.dart';
import '../viewmodel/youtube_video_provider.dart';

class DetailPage extends StatelessWidget {
  Movie movie;
  late YoutubeVideoProvider _youtubeVideoProvider;
  DetailPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _youtubeVideoProvider =
        Provider.of<YoutubeVideoProvider>(context, listen: true);

    _youtubeVideoProvider.id = movie.id.toString();
    _youtubeVideoProvider.loadVideo();

    String? key;
    // in case, the system still loadinig the data so there is no key yet, 
    // should let the program know
    if (_youtubeVideoProvider.video == null ||
        _youtubeVideoProvider.video!.results![0].key!.isEmpty) {
      key = null;
    } else {
      key = _youtubeVideoProvider.video!.results![0].key;
    }


    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // if there is no key data yet or there is still previous vedio modle exists, 
            // we need to wait untill request is done.
            key != null &&
                    movie.id.toString() ==
                        _youtubeVideoProvider.video!.id.toString()
                ? YoutubeVideoPlayer(
                    videoKey: key,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
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
                          const Row(
                            children: [
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
