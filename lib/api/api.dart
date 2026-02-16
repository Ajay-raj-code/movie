import 'package:dio/dio.dart';
import 'package:movie/models/detail_movie_model.dart';
import 'package:movie/models/sort_movie_model.dart';


/// I am using dio for calling api
/// i have implement only two type of request
/// first search by name
/// second search by id
class Api {
  final dio = Dio(
    BaseOptions(
      baseUrl: "http://www.omdbapi.com/?apikey=db83f23f",
      receiveTimeout: Duration(seconds: 10),
      connectTimeout: Duration(seconds: 10),
    ),
  );

  Future<List<SortMovieModel>> searchMovie({required String title}) async {
    try {
      final response = await dio.get("", queryParameters: {"s": title});
      if (response.statusCode == 200) {
        if (response.data["Response"] == "True") {
          final List<dynamic> movieList = response.data["Search"];
          List<SortMovieModel> movie = movieList
              .map((e) => SortMovieModel.fromJson(json: e))
              .toList();
          return movie;
        }
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<DetailMovieModel?> searchMovieImbdId({required String imbdId}) async {
    try {
      final response = await dio.get("", queryParameters: {"i": imbdId});
      if (response.statusCode == 200) {
        if (response.data["Response"] == "True") {
          Map<String, dynamic> data = response.data;
          DetailMovieModel movie = DetailMovieModel.fromJson(data);
          return movie;
        }
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
