import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/search_controller.dart';
import 'package:movie/utils/themes/app_colors.dart';
import 'package:movie/utils/widgets/search_text_field.dart';

class SearchResultScreen extends StatelessWidget{

  SearchResultScreen({super.key});
  final TextEditingController _controller = TextEditingController();
  final  _searchController = Get.put(SearchingController());

  @override
  Widget build(BuildContext context) {
    _controller.text = Get.arguments["search"];
    _searchController.searchMovie(title: _controller.text);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text("Search Results", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),),
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
            const SizedBox(height: 20,),
            Expanded(child: Obx(() => GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing:20,childAspectRatio:0.5), itemCount: _searchController.movies.length,itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {

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
                              image: DecorationImage(image: NetworkImage(_searchController.movies[index].poster), fit: BoxFit.cover)
                          ),
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              print(index);
                            },
                            child: Container(
                                width: 40,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGray.withAlpha(70),
                                  borderRadius: BorderRadius.circular(30)
                                ),
                                child: Icon(Icons.favorite_border_outlined, color: AppColors.white,)),
                          ),
                        ),
                      ),
                    ),
                    Text(_searchController.movies[index].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    Text(_searchController.movies[index].year, style: TextStyle(color: AppColors.darkGray),),

                  ],
                ),
              );
            },),)),
          ],
        ),
      ),
    );
  }

}