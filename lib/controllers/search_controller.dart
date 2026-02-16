import 'package:get/get.dart';
import 'package:movie/api/api.dart';
import 'package:movie/models/sort_movie_model.dart';

/// this controller controls the searching movie by name
/// it display the result
class SearchingController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<SortMovieModel> movies = <SortMovieModel>[].obs;

  Future<void> searchMovie({required String title}) async {
    isLoading.value = true;
    movies.clear();
    movies.addAll(await Api().searchMovie(title: title));
    isLoading.value = false;
  }
}
