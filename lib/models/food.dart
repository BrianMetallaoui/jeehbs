import 'dart:convert';

import 'package:jeehbs/models/models.dart';

class Food extends BaseModel {
  int? caloriesPerServing;
  int totalCalories;
  int servings;
  List<Ingredient> ingredients = [];
  String recipe;

  Food({
    String? id,
    String name = '',
    this.caloriesPerServing,
    this.totalCalories = 0,
    this.servings = 1,
    this.recipe = '',
    List<Ingredient>? ingredients,
  }) : super(name, id) {
    this.ingredients = (ingredients != null) ? ingredients : [Ingredient()];
  }

  int get calucateCalories {
    if (ingredients.isNotEmpty) {
      totalCalories = ingredients.fold(
        0,
        (prev, element) => (prev) + ((element.calories ?? 0) * element.amount),
      );
    }
    return (servings > 0) ? (totalCalories / servings).floor() : totalCalories;
  }

  void setCaloriesPerServing() {
    caloriesPerServing = calucateCalories;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'caloriesPerServing': caloriesPerServing,
      'totalCalories': totalCalories,
      'servings': servings,
      'ingredients': ingredients.map((x) => x.toMap()).toList(),
      'recipe': recipe,
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
              map['ingredients']?.map((x) => Ingredient.fromMap(x)),
            )
          : [],
      recipe: map['recipe'] ?? '',
    );
  }

  Food clone() {
    var x = Food.fromMap(toMap());
    x.newId();
    return x;
  }
}
