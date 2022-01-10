import 'dart:convert';

import 'package:jeehbs/models/models.dart';

class Food extends BaseModel {
  String name;
  int caloriesPerServing;
  int totalCalories;
  int servings;
  List<Ingredient> ingredients = [];

  Food({
    String? id,
    required this.name,
    required this.caloriesPerServing,
    required this.totalCalories,
    required this.servings,
    this.ingredients = const [],
  }) : super(id);

  static int calucateTotalCalories(Food food) {
    if (food.ingredients.isNotEmpty) {
      food.totalCalories =
          food.ingredients.fold(0, (prev, element) => prev + element.calories);
    }
    return calucateCaloriesPerServing(food);
  }

  static int calucateCaloriesPerServing(Food food) {
    return (food.servings > 0)
        ? (food.totalCalories / food.servings).floor()
        : food.totalCalories;
  }

  static String nameField = 'name';
  static String caloriesPerServingField = 'caloriesPerServing';
  static String totalCaloriesField = 'totalCalories';
  static String servingsField = 'servings';
  static Map<String, FParas> fields = {
    nameField: FParas(type: FType.string),
    caloriesPerServingField: FParas(type: FType.int),
    totalCaloriesField: FParas(type: FType.int),
    servingsField: FParas(type: FType.int),
  };

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'name': name,
      'caloriesPerServing': caloriesPerServing,
      'totalCalories': totalCalories,
      'servings': servings,
      'ingredients': ingredients.map((x) => x.toMap()).toList(),
    };
  }

  @override
  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) => Food.fromMap(json.decode(source));

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      id: map['id'],
      name: map['name'] ?? '',
      caloriesPerServing: map['caloriesPerServing']?.toInt() ?? 0,
      totalCalories: map['totalCalories']?.toInt() ?? 0,
      servings: map['servings']?.toInt() ?? 0,
      ingredients: map['ingredients'] != null
          ? List<Ingredient>.from(
              map['ingredients']?.map((x) => Ingredient.fromMap(x)))
          : [],
    );
  }
}
