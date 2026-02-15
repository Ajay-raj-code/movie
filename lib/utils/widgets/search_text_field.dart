import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/utils/themes/app_colors.dart';
class SearchTextFieldController extends GetxController{
  RxBool closeIconsVisibility = false.obs;
}

class SearchTextField extends StatelessWidget{
  final TextEditingController controller;
  final VoidCallback onSearch;
  final String hintText;
  const SearchTextField({super.key, required this.controller, this.hintText="", required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final clearFiledController = Get.put(SearchTextFieldController());
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.softBackground,
        borderRadius: BorderRadius.circular(30)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          GestureDetector(onTap: onSearch,child: Icon(Icons.search, color: AppColors.blue, size: 30,)),
          Expanded(
            child: TextFormField(
              controller: controller,
              onChanged: (value) {
                if(value.isEmpty){
                  clearFiledController.closeIconsVisibility.value =false;
                }else{
                  clearFiledController.closeIconsVisibility.value =true;

                }
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: AppColors.lightGray,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
              ),
            ),
          ),
          Obx(() => (clearFiledController.closeIconsVisibility.value)? GestureDetector(onTap: () {
            controller.clear();
            clearFiledController.closeIconsVisibility.value = false;
          },child: Icon(Icons.close)):SizedBox(),)
        ],
      ) ,
    );
  }

}

