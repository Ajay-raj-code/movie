import 'package:flutter/material.dart';
import 'package:movie/utils/themes/app_colors.dart';

/// this component is used to display custom list tile
Widget Component1({required String title, required String label}) {
  return Row(
    spacing: 20,
    children: [
      Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.blue.withAlpha(30),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppColors.blue.withAlpha(100), width: 1.0),
        ),
        child: const Icon(Icons.person, color: AppColors.blue, size: 30),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: AppColors.black,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppColors.lightGray,
            ),
          ),
        ],
      ),
    ],
  );
}
