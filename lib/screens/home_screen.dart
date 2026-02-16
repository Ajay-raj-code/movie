import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/favirote_controller.dart';
import 'package:movie/controllers/home_controller.dart';
import 'package:movie/utils/routes.dart';
import 'package:movie/utils/themes/app_colors.dart';
import 'package:movie/utils/widgets/search_text_field.dart';

///this is home screen
///it is also contains favourite list screen
///it work on bottom nav bar
class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final _homeController = Get.put(HomeController());
  final _faviroteController = Get.put(FaviroteController());

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => _homeController.currentBottomNavItem.value == 0
              ? Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Hero(
                      tag: "search_hero",
                      child: Material(
                        child: SearchTextField(
                          onSearch: () {
                            Get.toNamed(
                              Routes.searchResult,
                              arguments: {"search": _controller.text.trim()},
                            );
                          },
                          controller: _controller,
                          hintText: "Search for your favorite movies",
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      child: Obx(
                        () => GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                childAspectRatio: 0.5,
                              ),
                          itemCount: _faviroteController.movie.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  Routes.movieDetails,
                                  arguments: {
                                    "id":
                                        _faviroteController.movie[index].imdbId,
                                  },
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Material(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              _faviroteController
                                                  .movie[index]
                                                  .poster,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        alignment: Alignment.topRight,
                                        child: Obx(
                                          () => GestureDetector(
                                            onTap: () {
                                              _faviroteController.addInFavirote(
                                                _faviroteController
                                                    .movie[index],
                                              );
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: AppColors.lightGray
                                                    .withAlpha(70),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Icon(
                                                _faviroteController.movie.any(
                                                      (element) =>
                                                          element.imdbId ==
                                                          _faviroteController
                                                              .movie[index]
                                                              .imdbId,
                                                    )
                                                    ? Icons.favorite
                                                    : Icons
                                                          .favorite_border_outlined,
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _faviroteController.movie[index].title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    _faviroteController.movie[index].year,
                                    style: const TextStyle(
                                      color: AppColors.darkGray,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.lightGray.withAlpha(50), width: 2),
          ),
        ),
        child: Obx(
          () => BottomNavigationBar(
            currentIndex: _homeController.currentBottomNavItem.value,
            backgroundColor: AppColors.white,
            elevation: 5,
            selectedItemColor: AppColors.blue,
            unselectedItemColor: AppColors.darkGray,
            onTap: (value) {
              _homeController.currentBottomNavItem.value = value;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favorites",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
