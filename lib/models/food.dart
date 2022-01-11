import 'dart:convert';

import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/utils/my_save.dart';

class Food extends BaseModel {
  int caloriesPerServing;
  int totalCalories;
  int servings;
  List<Ingredient> ingredients = [];

  Food({
    String? id,
    required String name,
    required this.caloriesPerServing,
    required this.totalCalories,
    required this.servings,
    this.ingredients = const [],
  }) : super(name, id);

  void calucateTotalCalories() {
    if (ingredients.isNotEmpty) {
      totalCalories = ingredients.fold(
        0,
        (prev, element) => prev + ((element.calories ?? 0) * element.amount),
      );
    }
    calucateCaloriesPerServing();
  }

  void calucateCaloriesPerServing() {
    caloriesPerServing =
        (servings > 0) ? (totalCalories / servings).floor() : totalCalories;
  }

  static int mapTocalucateTotalCalories(Map<String, dynamic> input) {
    var f = Food.fromMap(input);
    if (f.ingredients.isNotEmpty) {
      f.totalCalories = f.ingredients.fold(
        0,
        (prev, element) => prev + ((element.calories ?? 0) * element.amount),
      );
    }
    return mapTocalucateCaloriesPerServing(f.toMap());
  }

  static int mapTocalucateCaloriesPerServing(Map<String, dynamic> input) {
    var f = Food.fromMap(input);
    return (f.servings > 0)
        ? (f.totalCalories / f.servings).floor()
        : f.totalCalories;
  }

  static String nameField = 'name';
  static String caloriesPerServingField = 'caloriesPerServing';
  static String totalCaloriesField = 'totalCalories';
  static String servingsField = 'servings';
  Map<String, FParas> fields() => {
        nameField: FParas(
          type: FType.string,
          initValue: name,
          whenSaved: (v) => name = mySave(v, FType.string),
        ),
        caloriesPerServingField: FParas(
          type: FType.int,
          initValue: caloriesPerServing,
          whenSaved: (v) => caloriesPerServing = mySave(v, FType.int),
        ),
        totalCaloriesField: FParas(
          type: FType.int,
          initValue: totalCalories,
          whenSaved: (v) => totalCalories = mySave(v, FType.int),
        ),
        servingsField: FParas(
          type: FType.int,
          initValue: servings,
          whenSaved: (v) => servings = mySave(v, FType.int),
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
