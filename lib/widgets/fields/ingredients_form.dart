import 'package:flutter/material.dart';
import 'package:jeehbs/models/models.dart';

import 'ingredient_form.dart';

class IngredientsForm extends FormField<List<Ingredient>> {
  IngredientsForm({
    Key? key,
    FormFieldSetter<List<Ingredient>>? onSaved,
    FormFieldValidator<List<Ingredient>>? validator,
    List<Ingredient> initialValue = const [],
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<List<Ingredient>> state) {
            return Column(
              children: [
                ...state.value!.map((e) => IngredientForm(e)).toList(),
                IconButton(
                  onPressed: () {
                    state.value?.add(Ingredient());
                    state.didChange(state.value);
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            );
          },
        );
}
