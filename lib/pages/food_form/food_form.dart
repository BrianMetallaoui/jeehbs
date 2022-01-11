import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/controllers/main_x.dart';
import 'package:jeehbs/data/foods.dart';
import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/widgets/fields/Ingredient_form.dart';
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
                      (Food s) => setState(() => refresh(s.clone())),
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
                          model.calucateTotalCalories.toString(),
                        )),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    setState(() {
                                      model.setCaloriesPerServing();
                                      refresh(model);
                                    });
                                  }
                                },
                                child: const Text('Calc'),
                              )
                            ],
                          ),
                        ),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    conX.saveFood(model);
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
