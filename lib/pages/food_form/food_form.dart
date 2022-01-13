import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/controllers/food_x.dart';
import 'package:jeehbs/data/foods.dart';
import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/my_fields/my_fields.dart';
import 'package:jeehbs/widgets/widgets.dart';

import './components/ingredient_form.dart';

class FoodForm extends StatefulWidget {
  const FoodForm({Key? key, this.food}) : super(key: key);
  final Food? food;

  @override
  State<FoodForm> createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  final _formKey = GlobalKey<FormState>();

  late Food model;
  late Map<String, FParas> fields;
  Widget f(String objKey, [String? helperText]) => myField(
        fields[objKey]!,
        helperText: helperText,
      );

  @override
  void initState() {
    super.initState();
    refresh(widget.food);
  }

  void refresh(Food? f) {
    model = (f != null) ? f : Food(ingredients: []);
    fields = model.fields();
  }

  String get cps => 'Calories Per Serving: ${model.caloriesPerServing ?? ''}';
  String get title =>
      (widget.food != null) ? 'Edit ${widget.food!.name}' : 'Add Food';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
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
}
