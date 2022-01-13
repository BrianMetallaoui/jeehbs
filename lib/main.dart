import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jeehbs/controllers/food_x.dart';
import 'package:jeehbs/pages/home_page/home_page.dart';
import 'package:jeehbs/repositories/food_repository.dart';

import 'utils/utils.dart';

void main() async {
  await GetStorage.init();
  Get.put(FoodRepository());
  Get.put(FoodX(Get.find<FoodRepository>()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primaryColor = const Color(0xFF004C54);
    var accentColor = const Color(0xFF565A5C);
    var primarySwatch = MaterialColor(
      primaryColor.value,
      getSwatch(primaryColor),
    );
    return GetMaterialApp(
      title: 'Jeehbs',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        primarySwatch: primarySwatch,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primarySwatch,
        ).copyWith(secondary: accentColor),
        bottomAppBarColor: primaryColor,
      ),
      home: const HomePage(),
    );
  }
}
