import 'package:flutter/material.dart';
import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/my_fields/my_fields.dart';

class IngredientForm extends StatelessWidget {
  const IngredientForm(this.ingredient, {Key? key}) : super(key: key);
  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    Map<String, FParas> fields = ingredient.fields();

    Widget f(String objKey, [String? helperText]) => myField(
          fields[objKey]!,
          helperText: helperText,
        );

    return Row(
      children: [
        Expanded(child: f(Ingredient.nameField)),
        Expanded(child: f(Ingredient.caloriesField)),
        Expanded(child: f(Ingredient.amountField)),
        Expanded(child: f(Ingredient.servingSizeField)),
      ],
    );
  }
}
