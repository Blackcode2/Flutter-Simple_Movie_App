import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_movie/viewmodel/now_movie_provider.dart';
import 'package:simple_movie/viewmodel/search_provider.dart';
import 'package:simple_movie/viewmodel/trending_provider.dart';
import 'package:simple_movie/viewmodel/youtube_video_provider.dart';
import 'package:simple_movie/view/home_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const seedColor = Color(0xffC0392B);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => MovieProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => TrendingProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => SearchProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => YoutubeVideoProvider()),

        // ChangeNotifierProvider(
        //     create: (BuildContext context) => DotsIndicatorProvider()
        // ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: seedColor,
              brightness: Brightness.dark,
            ),
            // textTheme: GoogleFonts.notoSansTextTheme(
            //   Theme.of(context)
            //     .textTheme,
          ),
          home: HomeScreen()),
    );
  }
}
