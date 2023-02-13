import 'package:flutter/material.dart';

import 'detail_screen.dart';

class MoviePoster extends StatelessWidget {
  var provider;

  MoviePoster({required this.provider, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.28,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: provider.movies.length,
            itemBuilder: (BuildContext context, int idx) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(movie: provider.movies[idx])));
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      provider.movies[idx].postUrl,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

// Padding(
// padding: const EdgeInsets.all(10.0),
// child: Card(
// shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
// borderRadius: BorderRadius.circular(18.0),
// ),
// color: Colors.white,
// child: SizedBox(
// height: size.height,
// width: size.width * 0.7,
// child: const Center(
// child: Text('test'),
// ),
// ),
// ),
// );
