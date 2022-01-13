import 'dart:convert';

import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/utils/utils.dart';

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
  Map<String, MyFieldParameters> fields() => {
        nameField: MyFieldParameters(
          type: MyFieldType.string,
          initValue: name,
          objKey: nameField,
          whenSaved: (v) => name = mySave(v, MyFieldType.string),
        ),
        caloriesField: MyFieldParameters(
          type: MyFieldType.int,
          objKey: caloriesField,
          initValue: calories,
          whenSaved: (v) => calories = mySave(v, MyFieldType.int),
        ),
        servingSizeField: MyFieldParameters(
          type: MyFieldType.string,
          objKey: servingSizeField,
          initValue: servingSize,
          whenSaved: (v) => servingSize = mySave(v, MyFieldType.string),
        ),
        amountField: MyFieldParameters(
          type: MyFieldType.int,
          objKey: amountField,
          initValue: amount,
          whenSaved: (v) => amount = mySave(v, MyFieldType.int),
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
