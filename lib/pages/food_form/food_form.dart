import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/controllers/main_x.dart';
import 'package:jeehbs/data/foods.dart';
import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/widgets/fields/ingredients_form.dart';
import 'package:jeehbs/widgets/fields/my_autocomplete.dart';
import 'package:jeehbs/widgets/fields/my_field.dart';

class FoodForm extends StatefulWidget {
  const FoodForm({Key? key, this.food}) : super(key: key);
  final Food? food;

  @override
  State<FoodForm> createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  final _formKey = GlobalKey<FormState>();

  late Map<String, dynamic> model;
  Widget f(String objKey, [String? helperText]) => myField(
        model,
        objKey,
        Food.fields()[objKey]!,
        helperText: helperText,
      );

  @override
  void initState() {
    super.initState();
    model = (widget.food != null) ? widget.food!.toMap() : {};
  }

  String get cps =>
      'Calories Per Serving: ${model[Food.caloriesPerServingField] ?? ''}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (widget.food != null) ? 'Edit ${widget.food!.name}' : 'Add Food',
        ),
      ),
      body: Center(
        child: GetBuilder<MainX>(
          builder: (conX) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyAutocomplete<Food>(
                      foods,
                      (Food s) => setState(() => model = s.clone().toMap()),
                    ),
                    f(Food.nameField),
                    Row(
                      children: [
                        Expanded(child: f(Food.totalCaloriesField)),
                        Expanded(child: f(Food.servingsField)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: f(
                          Food.caloriesPerServingField,
                          Food.mapTocalucateTotalCalories(model).toString(),
                        )),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    var food = Food.fromMap(model)
                                      ..calucateTotalCalories();
                                    setState(() => model = food.toMap());
                                  }
                                },
                                child: const Text('Calc'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IngredientsForm(
                initialValue: (model['ingredients'] != null)
                    ? List<Ingredient>.from(
                        model['ingredients']?.map((x) => Ingredient.fromMap(x)),
                      )
                    : [],
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    var food = Food.fromMap(model);
                    conX.saveFood(food);
                    Get.back();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
