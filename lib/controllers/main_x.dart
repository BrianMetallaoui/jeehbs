import 'package:get/get.dart';
import 'package:jeehbs/models/models.dart';

class MainX extends GetxController {
  List<Food> foods = [];

  void saveFood(Food food) {
    var x = foods.indexWhere((i) => i.id == food.id);
    if (x > -1) {
      foods[x] = food;
    } else {
      foods.add(food);
    }
    update();
  }
}
