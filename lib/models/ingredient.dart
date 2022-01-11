import 'dart:convert';

import 'package:jeehbs/models/base_model.dart';
import 'package:jeehbs/models/f_paras.dart';
import 'package:jeehbs/utils/my_save.dart';

class Ingredient extends BaseModel {
  int? calories;
  int amount;
  String? servingSize;

  Ingredient({
    String? id,
    String? name,
    this.calories,
    this.servingSize,
    this.amount = 1,
  }) : super(name, id);

  static String nameField = 'name';
  static String caloriesField = 'calories';
  static String servingSizeField = 'servingSize';
  static String amountField = 'amount';
  Map<String, FParas> fields() => {
        nameField: FParas(
          type: FType.string,
          initValue: name,
          objKey: nameField,
          whenSaved: (v) => name = mySave(v, FType.string),
        ),
        caloriesField: FParas(
          type: FType.int,
          objKey: caloriesField,
          initValue: calories,
          whenSaved: (v) => calories = mySave(v, FType.int),
        ),
        servingSizeField: FParas(
          type: FType.string,
          objKey: servingSizeField,
          initValue: servingSize,
          whenSaved: (v) => servingSize = mySave(v, FType.string),
        ),
        amountField: FParas(
          type: FType.int,
          objKey: amountField,
          initValue: amount,
          whenSaved: (v) => amount = mySave(v, FType.int),
        ),
      };

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'calories': calories,
      'servingSize': servingSize,
      'amount': amount,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      id: map['id'],
      name: map['name'] ?? '',
      calories: map['calories']?.toInt() ?? 0,
      servingSize: map['servingSize'] ?? '',
      amount: map['amount']?.toInt() ?? 1,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Ingredient.fromJson(String source) =>
      Ingredient.fromMap(json.decode(source));
}
