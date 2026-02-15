import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/home_controller.dart';
import 'package:movie/utils/routes.dart';
import 'package:movie/utils/themes/app_colors.dart';
import 'package:movie/utils/widgets/search_text_field.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _homeController = Get.put(HomeController());
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() => _homeController.currentBottomNavItem.value == 0? Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Search",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
            ),
            Hero(
              tag: "search_hero",
              child: Material(
                child: SearchTextField(
                  onSearch: () {
                    Get.toNamed(Routes.searchResult, arguments: {"search":_controller.text.trim()});

                  },
                  controller: _controller,
                  hintText: "Search for your favorite movies",
                ),
              ),
            ),
          ],
        ):Column(),),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.lightGray.withAlpha(50), width: 2),
          ),
        ),
        child: Obx(() => BottomNavigationBar(
          currentIndex: _homeController.currentBottomNavItem.value,
          backgroundColor: AppColors.white,
          elevation: 5,
          selectedItemColor: AppColors.blue,
          unselectedItemColor: AppColors.darkGray,
          onTap: (value) {
            print(value);
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
        ),),
      ),
    );
  }
}
