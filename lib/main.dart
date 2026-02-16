import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/utils/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Movie',
      initialRoute: Routes.home,
      getPages: Routes().pages,
    );
  }
}
