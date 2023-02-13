import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_movie/ui/carousel_slider.dart';
import '../controller/now_movie_provider.dart';
import '../controller/trending_provider.dart';
import 'search_screen.dart';
import 'movie_poster.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  late MovieProvider _movieProvider;
  late TrendingProvider _trendingProvider;

  @override
  Widget build(BuildContext context) {
    _movieProvider = Provider.of<MovieProvider>(context, listen: false);
    _movieProvider.loadMovies();
    _trendingProvider = Provider.of<TrendingProvider>(context, listen: true);
    _trendingProvider.loadMovies();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: IconButton(
              onPressed: null,
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              iconSize: 30.0,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            )),
        centerTitle: true,
        title: const Text(
          'TMDB',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              iconSize: 30.0,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                    child: Text(
                      'Cinema Now',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: _movieProvider.movies != null
                    ? MovieCarouselSlider()
                    : const LoadingCarouselSlider(),
              ),
              // DotsIndicator(
              //   dotsCount: _movieProvider.movies!.length,
              //   position: Provider.of<DotsIndicatorProvider>(context, listen: false).index.toDouble(),
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Row(
                  children: const [
                    Text(
                      'Trending',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              MoviePoster(provider: _trendingProvider),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.text_snippet),
      //       label: '나의 판매글',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: '홈',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.people),
      //       label: '마이페이지',
      //     ),
      //   ],
      //   // currentIndex: _selectedIndex, // 지정 인덱스로 이동
      //   // selectedItemColor: Colors.lightGreen,
      //   // onTap: _onItemTapped, // 선언했던 onItemTapped
      // ),
    );
  }
}
