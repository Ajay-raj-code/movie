import 'package:get/get.dart';
import 'package:movie/api/api.dart';
import 'package:movie/models/detail_movie_model.dart';

class MovieDetailsController extends GetxController{
  Rx<DetailMovieModel?> movie = null.obs;

  Future<void> searchMovieById({required String id})async{
    movie.value = await Api().searchMovieImbdId(imbdId: id);
  }
}