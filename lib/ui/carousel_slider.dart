import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_movie/controller/now_movie_provider.dart';

import 'detail_screen.dart';

class MovieCarouselSlider extends StatelessWidget {
  MovieCarouselSlider({Key? key}) : super(key: key);
  late MovieProvider _movieProvider;
  // late DotsIndicatorProvider _dotsIndicatorProvider;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _movieProvider = Provider.of<MovieProvider>(context, listen: true);
    // _dotsIndicatorProvider = Provider.of<DotsIndicatorProvider>(context, listen: false);
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.5,
        viewportFraction: 0.60,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        // onPageChanged: (index, reason) {
        //   // setState(() {
        //   //   _current = index;
        //   // });
        //   _dotsIndicatorProvider.index = index.toDouble();
        // }
      ),
      items: _movieProvider.movies!.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                              movie: item,
                            )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  item.postUrl,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class LoadingCarouselSlider extends StatelessWidget {
  const LoadingCarouselSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
        height: 380.0,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
      ),
      items: [0, 0, 0].map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(16.0)),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
