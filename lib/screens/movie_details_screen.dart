import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/movie_details_controller.dart';
import 'package:movie/main.dart';
import 'package:movie/utils/themes/app_colors.dart';

class MovieDetailsScreen extends StatefulWidget{
  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final _movieDetailsController = Get.put(MovieDetailsController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String id = Get.arguments["id"];
    _movieDetailsController.searchMovieById(id: id);


  }
  @override
  Widget build(BuildContext context) {
    final movie = _movieDetailsController.movie.value;
    print(movie);
    return Obx(() => (movie == null)? CircularProgressIndicator():Scaffold(
      appBar: AppBar(
        leading: Container(
            width: 50,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.lightGray.withAlpha(70),
                borderRadius: BorderRadius.circular(30)
            ),
            child: Icon(Icons.favorite_border_outlined, color: AppColors.white,)),
        actions: [
          Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.lightGray.withAlpha(70),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Icon(Icons.favorite_border_outlined, color: AppColors.white,)),

        ],
      ),

      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(movie.poster),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Gradient Overlay
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.softBackground.withAlpha(100),
                  ],
                ),
              ),
            ),

            Positioned(child: Material(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  spacing: 10,
                  children: [
                    Text(movie.title, style: TextStyle(color: AppColors.black, fontSize: 30, fontWeight: FontWeight.bold),),
                    Text("${movie.year} · ${movie.rated} · ${movie.runtime}", style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.w700),),
                    for(int i = 0; i< movie.genre.length; i++)
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.blue.withAlpha(20),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Text(movie.genre[i], style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),),
                      ),

                    const SizedBox(height: 10,),
                    Divider(thickness: 2, color: AppColors.lightGray.withAlpha(25),),
                    Row(
                      spacing: 10,
                      children: [
                        for(int i = 0; i< movie.ratings.length; i++)
                          Column(
                            children: [
                              Text(movie.ratings[i].source, style: TextStyle(color: AppColors.darkGray,fontWeight: FontWeight.bold),),
                              Row(
                                children: [
                                  Icon(Icons.star, color: AppColors.yellow,),
                                  Text(movie.ratings[i].value, style: TextStyle(color: AppColors.black, fontSize: 22),),
                                ],
                              ),

                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 10,),

                    Divider(thickness: 2, color: AppColors.lightGray.withAlpha(25),),
                    const SizedBox(height: 10,),
                    Text("PLOT", style: TextStyle(color: AppColors.darkGray, fontWeight: FontWeight.bold),),
                    Expanded(child: Text(movie.plot), ),



                  ],
                ),

              ),
            ))

          ],
        ),
      ),
    ),);
  }
}