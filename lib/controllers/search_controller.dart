import 'package:get/get.dart';
import 'package:movie/api/api.dart';
import 'package:movie/models/sort_movie_model.dart';

class SearchingController extends GetxController{
  RxBool isLoading = false.obs;
  RxList<SortMovieModel> movies = <SortMovieModel>[].obs;

  Future<void> searchMovie({required String title}) async{
    print("search controller is working");
    isLoading.value = true;
    movies.clear();
    movies.addAll(await Api().searchMovie(title: title));
    print(movies.length);
    isLoading.value = false;
  }
}