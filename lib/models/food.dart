import 'dart:convert';

import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/utils/utils.dart';

class Food extends BaseModel {
  int? caloriesPerServing;
  int? totalCalories;
  int? servings;
  List<Ingredient> ingredients = [];

  Food({
    String? id,
    String name = '',
    this.caloriesPerServing,
    this.totalCalories,
    this.servings,
    required this.ingredients,
  }) : super(name, id);

  int get calucateTotalCalories {
    if (ingredients.isNotEmpty) {
      totalCalories = ingredients.fold(
        0,
        (prev, element) =>
            (prev ?? 0) + ((element.calories ?? 0) * element.amount),
      );
    }
    return calucateCaloriesPerServing() ?? 0;
  }

  int? calucateCaloriesPerServing() {
    return ((servings ?? 0) > 0)
        ? ((totalCalories ?? 0) / (servings ?? 1)).floor()
        : totalCalories;
  }

  void setCaloriesPerServing() {
    caloriesPerServing = calucateTotalCalories;
  }

  static String nameField = 'name';
  static String caloriesPerServingField = 'caloriesPerServing';
  static String totalCaloriesField = 'totalCalories';
  static String servingsField = 'servings';
  Map<String, MyFieldParameters> fields() => {
        nameField: MyFieldParameters(
          type: MyFieldType.string,
          objKey: nameField,
          initValue: name,
          whenSaved: (v) => name = mySave(v, MyFieldType.string),
        ),
        caloriesPerServingField: MyFieldParameters(
          type: MyFieldType.int,
          objKey: caloriesPerServingField,
          initValue: caloriesPerServing,
          whenSaved: (v) => caloriesPerServing = mySave(v, MyFieldType.int),
        ),
        totalCaloriesField: MyFieldParameters(
          type: MyFieldType.int,
          objKey: totalCaloriesField,
          initValue: totalCalories,
          whenSaved: (v) => totalCalories = mySave(v, MyFieldType.int),
        ),
        servingsField: MyFieldParameters(
          type: MyFieldType.int,
          objKey: servingsField,
          initValue: servings,
          whenSaved: (v) => servings = mySave(v, MyFieldType.int),
        ),
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
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

  Food clone() {
    var x = Food.fromMap(toMap());
    x.newId();
    return x;
  }
}
