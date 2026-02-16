import 'package:get/get.dart';
import 'package:movie/database/app_database.dart';
import 'package:movie/models/sort_movie_model.dart';

///this controller control the favirote list of movies
///this list auto update when some is add or remove from favirote list
class FaviroteController extends GetxController {
  RxList<SortMovieModel> movie = <SortMovieModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> onIntialization() async {
    movie.addAll(await AppDatabase().getFavorite());
  }

  Future<void> addInFavirote(SortMovieModel movies) async {
    await AppDatabase().addFavorite(movies);
    movie.clear();
    movie.addAll(await AppDatabase().getFavorite());
  }
}
