import 'package:flutter/material.dart';
import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/my_fields/my_fields.dart';
import 'package:jeehbs/widgets/widgets.dart';

class IngredientForm extends StatelessWidget {
  const IngredientForm(this.ingredient, {Key? key}) : super(key: key);
  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    Map<String, MyFieldParameters> fields = ingredient.fields();

    Widget f(String objKey, [String? helperText]) => myField(
          fields[objKey]!,
          helperText: helperText,
        );

    return ExpandedRow(
      children: [
        f(Ingredient.nameField),
        f(Ingredient.caloriesField),
        f(Ingredient.amountField),
        f(Ingredient.servingSizeField),
      ],
    );
  }
}
