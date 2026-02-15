import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/movie_details_controller.dart';
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
    return Obx(() => Scaffold(
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

      body: Stack(

      ),
    ),);
  }
}