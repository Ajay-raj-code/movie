import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/favirote_controller.dart';
import 'package:movie/controllers/search_controller.dart';
import 'package:movie/utils/routes.dart';
import 'package:movie/utils/themes/app_colors.dart';
import 'package:movie/utils/widgets/search_text_field.dart';

/// this class is used to display the result of searching movie
class SearchResultScreen extends StatefulWidget {
  SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final TextEditingController _controller = TextEditingController();
  final faviroteController = Get.put(FaviroteController());
  final _searchController = Get.put(SearchingController());
  @override
  void initState() {
    super.initState();
    _controller.text = Get.arguments["search"];
    _searchController.searchMovie(title: _controller.text);
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          "Search Results",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Hero(
              tag: "search_hero",
              child: Material(
                child: SearchTextField(
                  onSearch: () {
                    _searchController.searchMovie(title: _controller.text);
                  },
                  controller: _controller,
                  hintText: "Search for your favorite movies",
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.5,
                  ),
                  itemCount: _searchController.movies.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.movieDetails,
                          arguments: {
                            "id": _searchController.movies[index].imdbId,
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
                                  borderRadius: BorderRadius.circular(30),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      _searchController.movies[index].poster,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                alignment: Alignment.topRight,
                                child: Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      faviroteController.addInFavirote(
                                        _searchController.movies[index],
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
                                        faviroteController.movie.any(
                                              (element) =>
                                                  element.imdbId ==
                                                  _searchController
                                                      .movies[index]
                                                      .imdbId,
                                            )
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            _searchController.movies[index].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            _searchController.movies[index].year,
                            style: const TextStyle(color: AppColors.darkGray),
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
    );
  }
}
