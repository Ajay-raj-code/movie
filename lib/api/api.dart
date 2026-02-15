import 'package:dio/dio.dart';
import 'package:movie/models/detail_movie_model.dart';
import 'package:movie/models/sort_movie_model.dart';

class Api{
  final dio = Dio(
    BaseOptions(
      baseUrl: "http://www.omdbapi.com/?apikey=db83f23f",
      receiveTimeout: Duration(seconds: 10),
      connectTimeout: Duration(seconds: 10)
    )
  );


  Future<List<SortMovieModel>> searchMovie({required String title}) async{

    try{
      final response = await dio.get("", queryParameters: {"s": title});
      print("stage 1");
      if(response.statusCode == 200){
        print("stage 2");
        print(response.data);
        if(response.data["Response"]=="True"){
          print("Stage 3");
          final List<dynamic> movieList = response.data["Search"];
          print(movieList.length);
          List<SortMovieModel> movie = movieList.map((e) => SortMovieModel.fromJson( json: e)).toList();
          return movie;
        }
      }
      return [];
    }
    catch (e){
      print(e);
      return [];
    }

  }
  Future<DetailMovieModel?> searchMovieImbdId({required String imbdId}) async{

    try{
      final response = await dio.get("", queryParameters: {"i": imbdId});
      print("stage 1");
      if(response.statusCode == 200){
        print("stage 2");
        print(response.data);
        if(response.data["Response"]=="True"){
          print("Stage 3");
          
          DetailMovieModel movie = response.data.map((e) => DetailMovieModel.fromJson( e));
          return movie;
        }
      }
      return null;
    }
    catch (e){
      print(e);
      return null;
    }

  }

}