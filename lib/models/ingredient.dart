import 'dart:convert';

import 'package:jeehbs/models/base_model.dart';
import 'package:jeehbs/models/f_paras.dart';

class Ingredient extends BaseModel {
  String name;
  int calories;
  String servingSize;

  Ingredient({
    String? id,
    required this.name,
    required this.calories,
    required this.servingSize,
  }) : super(id);

  static String nameField = 'name';
  static String caloriesField = 'calories';
  static String servingSizeField = 'servingSize';
  static Map<String, FParas> fields = {
    nameField: FParas(type: FType.string),
    caloriesField: FParas(type: FType.int),
    servingSizeField: FParas(type: FType.string),
  };

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'name': name,
      'calories': calories,
      'servingSze': servingSize,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'],
      name: map['name'] ?? '',
      calories: map['calories']?.toInt() ?? 0,
      servingSize: map['servingSze'] ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source));
}
