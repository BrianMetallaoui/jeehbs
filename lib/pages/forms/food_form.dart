import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/controllers/main_x.dart';
import 'package:jeehbs/models/food.dart';
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
  Widget f(String key) => myField(model, key, Food.fields[key]!);

  @override
  void initState() {
    super.initState();
    model = (widget.food != null) ? widget.food!.toMap() : {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            (widget.food != null) ? 'Edit ${widget.food!.name}' : 'Add Food'),
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
                          child: Text(
                              'Calories Per Serving: ${model[Food.caloriesPerServingField] ?? ''}'),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                var food = Food.fromMap(model);
                                setState(() {
                                  model[Food.caloriesPerServingField] =
                                      Food.calucateTotalCalories(food);
                                });
                              }
                            },
                            child: const Text('Calc'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
