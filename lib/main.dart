import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jeehbs/controllers/food_x.dart';
import 'package:jeehbs/data/food_repository.dart';
import 'package:jeehbs/pages/home_page/home_page.dart';
import 'package:jeehbs/utils/color_functions.dart';

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
    return GetMaterialApp(
      title: 'Jeehbs',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF004C54),
          primary: const Color(0xFF004C54),
          secondary: const Color(0xFF565A5C),
        ),
        bottomAppBarColor: const Color(0xFF004C54),
      ),
      home: const HomePage(),
    );
  }
}

void mains() {
  // Find fir
  DateTime today = DateTime.now();

  print(findFirstDateOfTheWeek(today));

  print(findLastDateOfTheWeek(today));

  print(findFirstDateOfTheMonth(today));
  print(findLastDateOfTheMonth(today));
}

/// Find the first date of the week which contains the provided date.

DateTime findFirstDateOfTheWeek(DateTime dateTime) {
  return dateTime.subtract(Duration(days: dateTime.weekday));
}

/// Find last date of the week which contains provided date.

DateTime findLastDateOfTheWeek(DateTime dateTime) {
  return dateTime
      .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday - 1));
}

/// Find the first date of the month which contains the provided date.

DateTime findFirstDateOfTheMonth(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month, 1);
}

/// Find last date of the month which contains provided date.

DateTime findLastDateOfTheMonth(DateTime dateTime) {
  return DateTime(dateTime.year, dateTime.month + 1, 0);
}
