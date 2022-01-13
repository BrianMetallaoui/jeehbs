import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/constants/constants.dart';
import 'package:jeehbs/controllers/controllers.dart';
import 'package:jeehbs/models/models.dart';

class FoodTile extends StatelessWidget {
  const FoodTile(this.food, {Key? key}) : super(key: key);
  final Food food;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text((food.name ?? '???')),
      subtitle: Text(food.servings.toString()),
      trailing: Text(food.caloriesPerServing.toString()),
      onTap: () => Get.toNamed(
        RoutePath.foodForm,
        arguments: {Argument.food: food},
      ),
      onLongPress: () => Get.find<FoodX>().deleteItem(food),
    );
  }
}
