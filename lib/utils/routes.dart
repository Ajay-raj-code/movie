import 'package:get/get.dart';
import 'package:movie/screens/home_screen.dart';
import 'package:movie/screens/search_result_screen.dart';

class Routes{
  static const String home = "/";
  static const String searchResult = "/search_result";

  List<GetPage> pages = [
    GetPage(name: home, page: () => HomeScreen(),),
    GetPage(name: searchResult, page: () => SearchResultScreen(),),
  ];
}