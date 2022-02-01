import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/controllers/food_x.dart';
import 'package:jeehbs/models/food.dart';
import 'package:jeehbs/pages/food_form/food_form.dart';

class FoodTile extends StatelessWidget {
  const FoodTile(this.food, {Key? key}) : super(key: key);
  final Food food;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(food.name),
      subtitle: Text(food.servings.toString()),
      trailing: Text(food.caloriesPerServing.toString()),
      onTap: () => Get.to(() => FoodForm(food: food)),
      onLongPress: () => Get.find<FoodX>().deleteItem(food),
    );
  }
}
