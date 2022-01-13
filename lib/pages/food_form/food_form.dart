import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/constants/constants.dart';
import 'package:jeehbs/controllers/controllers.dart';
import 'package:jeehbs/data/data.dart';
import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/utils/utils.dart';
import 'package:jeehbs/widgets/widgets.dart';

import './components/ingredient_form.dart';

class FoodForm extends StatefulWidget {
  const FoodForm({Key? key}) : super(key: key);

  @override
  State<FoodForm> createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  final _formKey = GlobalKey<FormState>();

  late Food model;
  late Map<String, MyFieldParameters> fields;

  var editing = false;

  @override
  void initState() {
    super.initState();
    var input = Get.arguments?[Argument.food];
    editing = (input != null);
    refresh(input);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((editing) ? 'Edit ${model.name}' : 'Add Food'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  MyAutocomplete<Food>(
                    foods,
                    (Food s) => setState(() => refresh(s.clone())),
                  ),
                  f(Food.nameField),
                  ExpandedRow(
                    children: [
                      f(Food.totalCaloriesField),
                      f(Food.servingsField),
                    ],
                  ),
                  ExpandedRow(
                    children: [
                      f(
                        Food.caloriesPerServingField,
                        model.calucateTotalCalories.toString(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: cpsFresh,
                            child: const Text('Calc'),
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ...model.ingredients
                          .map((e) => IngredientForm(e))
                          .toList(),
                      IconButton(
                        onPressed: () {
                          _formKey.currentState!.save();
                          setState(() {
                            model.ingredients.add(Ingredient());
                            refresh(model);
                          });
                        },
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _save,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget f(String objKey, [String? helperText]) => myField(
        fields[objKey]!,
        helperText: helperText,
      );

  void refresh(Food? f) {
    model = (f != null) ? f : Food(ingredients: []);
    fields = model.fields();
  }

  String get cps => 'Calories Per Serving: ${model.caloriesPerServing ?? ''}';

  void cpsFresh() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        model.setCaloriesPerServing();
        refresh(model);
      });
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Get.find<FoodX>().saveItem(model);
      Get.back();
    }
  }
}
