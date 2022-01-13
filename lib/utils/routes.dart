import 'package:get/get.dart';
import 'package:jeehbs/constants/constants.dart';
import 'package:jeehbs/pages/pages.dart';

var getPages = [
  GetPage(name: RoutePath.home, page: () => const HomePage()),
  GetPage(name: RoutePath.foodForm, page: () => const FoodForm()),
];
