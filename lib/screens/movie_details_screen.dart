import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/movie_details_controller.dart';
import 'package:movie/models/sort_movie_model.dart';
import 'package:movie/utils/themes/app_colors.dart';
import 'package:movie/utils/widgets/component1.dart';

import '../controllers/favirote_controller.dart' show FaviroteController;

/// it is shows complete descreption of the movie
class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final _movieDetailsController = Get.put(MovieDetailsController());
  final _faviroteController = Get.put(FaviroteController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String id = Get.arguments["id"];
    _movieDetailsController.searchMovieById(id: id);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.softBackground,
      body: Obx(() {
        final movie = _movieDetailsController.movie.value;
        return (movie == null)
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 350,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(movie.poster),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          // Gradient Overlay
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 350,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.transparent,
                                    AppColors.softBackground,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 30,
                            left: 10,
                            right: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGray.withAlpha(70),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      _faviroteController.addInFavirote(
                                        SortMovieModel(
                                          title: movie.title,
                                          year: movie.year,
                                          imdbId: movie.imdbID,
                                          type: movie.type,
                                          poster: movie.poster,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: AppColors.lightGray.withAlpha(
                                          70,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Icon(
                                        _faviroteController.movie.any(
                                              (element) =>
                                                  element.imdbId ==
                                                  movie.imdbID,
                                            )
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(30),
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          spacing: 10,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: const TextStyle(
                                color: AppColors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${movie.year} · ${movie.rated} · ${movie.runtime}",
                              style: const TextStyle(
                                color: AppColors.blue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              spacing: 10,
                              children: [
                                for (int i = 0; i < movie.genre.length; i++)
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.blue.withAlpha(20),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      movie.genre[i],
                                      style: const TextStyle(
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 10),
                            Divider(
                              thickness: 2,
                              color: AppColors.lightGray.withAlpha(25),
                            ),
                            Row(
                              spacing: 20,
                              children: [
                                for (int i = 0; i < movie.ratings.length; i++)
                                  Flexible(
                                    child: Column(
                                      spacing: 5,
                                      children: [
                                        Text(
                                          movie.ratings[i].source,
                                          style: const TextStyle(
                                            color: AppColors.darkGray,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: AppColors.blue,
                                            ),
                                            Text(
                                              movie.ratings[i].value,
                                              style: const TextStyle(
                                                color: AppColors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            Divider(
                              thickness: 2,
                              color: AppColors.lightGray.withAlpha(25),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "PLOT",
                              style: TextStyle(
                                color: AppColors.darkGray,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(movie.plot),

                            const SizedBox(height: 10),

                            Divider(
                              thickness: 2,
                              color: AppColors.lightGray.withAlpha(25),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "CAST & CREW",
                              style: TextStyle(
                                color: AppColors.darkGray,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Component1(
                              title: movie.director,
                              label: "Director",
                            ),
                            for (int i = 0; i < movie.actors.length; i++)
                              Component1(
                                title: movie.actors[i],
                                label: "Actors",
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
