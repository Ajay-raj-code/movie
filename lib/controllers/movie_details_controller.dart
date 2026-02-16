import 'package:get/get.dart';
import 'package:movie/api/api.dart';
import 'package:movie/models/detail_movie_model.dart';

/// this is responsible for getting complete detail for perticular movie
class MovieDetailsController extends GetxController {
  Rxn<DetailMovieModel> movie = Rxn<DetailMovieModel>();

  Future<void> searchMovieById({required String id}) async {
    movie.value = (await Api().searchMovieImbdId(imbdId: id))!;
  }
}
