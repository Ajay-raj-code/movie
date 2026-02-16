import 'package:get/get.dart';
import 'package:movie/screens/home_screen.dart';
import 'package:movie/screens/movie_details_screen.dart';
import 'package:movie/screens/search_result_screen.dart';

class Routes{
  static const String home = "/";
  static const String searchResult = "/search_result";
  static const String movieDetails = "/movie_details";

  List<GetPage> pages = [
    GetPage(name: home, page: () => HomeScreen(),),
    GetPage(name: searchResult, page: () => SearchResultScreen(),),
    GetPage(name: movieDetails, page: () => MovieDetailsScreen(),),
  ];
}