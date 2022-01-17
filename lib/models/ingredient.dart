import 'dart:convert';

import 'package:jeehbs/models/models.dart';

class Ingredient extends BaseModel {
  int? calories;
  int amount;

  Ingredient({
    String? id,
    String name = '',
    this.calories,
    this.amount = 1,
  }) : super(name, id);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'calories': calories,
      'amount': amount,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'],
      name: map['name'] ?? '',
      calories: map['calories']?.toInt() ?? 0,
      amount: map['amount']?.toInt() ?? 1,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source));
}
