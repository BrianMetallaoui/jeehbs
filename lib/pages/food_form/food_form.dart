import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/controllers/food_x.dart';
import 'package:jeehbs/models/food.dart';
import 'package:jeehbs/pages/food_form/components/search_foods.dart';
import 'package:jeehbs/widgets/widgets.dart';

import 'components/ingredient_grid.dart';
import 'components/show_ingredient.dart';
import 'components/bot_nav_button.dart';

class FoodForm extends StatefulWidget {
  const FoodForm({Key? key, this.food}) : super(key: key);
  final Food? food;

  @override
  State<FoodForm> createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  final _formKey = GlobalKey<FormState>();

  late Food food;

  var editing = false;
  late String thisId;

  @override
  void initState() {
    super.initState();
    thisId = widget.food?.id ?? '';
    editing = (widget.food != null);
    refresh(widget.food);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((editing) ? 'Edit ${food.name}' : 'Add Food'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            key: UniqueKey(),
                            initialValue: food.recipe,
                            keyboardType: TextInputType.multiline,
                            expands: true,
                            maxLines: null,
                            textAlign: TextAlign.start,
                            decoration: const InputDecoration(
                              label: Text('Recipe'),
                            ),
                            onSaved: (v) => food.recipe = v ?? '',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ExpandedRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: UniqueKey(),
                        initialValue: food.name,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          label: Text('Name'),
                        ),
                        onSaved: (v) => food.name = v ?? '',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: UniqueKey(),
                        initialValue: (food.servings).toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Servings'),
                        ),
                        onFieldSubmitted: (v) {
                          food.servings = int.tryParse(v) ?? 1;
                          cpsFresh();
                        },
                        onSaved: (v) =>
                            food.servings = int.tryParse(v ?? '') ?? 1,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Ingredients: ${food.ingredients.length}'),
                      Text('Calorie Count: ${food.calucateCalories}'),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: IngredientGrid(
                      ingredients: food.ingredients,
                      onTap: (input) async {
                        var ing = await showIngredient(input);
                        if (ing != null) {
                          _formKey.currentState!.save();

                          setState(() {
                            var existing = food.ingredients
                                .indexWhere((c) => c.id == ing.id);
                            if (existing != -1) {
                              food.ingredients[existing] = ing;
                            } else {
                              food.ingredients.add(ing);
                            }
                          });
                          cpsFresh();
                        }
                      },
                      delete: (ing) => setState(() {
                        _formKey.currentState!.save();
                        food.ingredients.remove(ing);
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _save,
        child: const Icon(Icons.save),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BotNavButton(
                  label: 'Add',
                  icon: Icons.add,
                  onTap: () async {
                    var ing = await showIngredient();
                    if (ing != null) {
                      _formKey.currentState!.save();

                      setState(() {
                        var existing =
                            food.ingredients.indexWhere((c) => c.id == ing.id);
                        if (existing != -1) {
                          food.ingredients[existing] = ing;
                        } else {
                          food.ingredients.add(ing);
                        }
                      });
                      cpsFresh();
                    }
                  },
                ),
                const SizedBox(width: 20),
                BotNavButton(
                  label: 'Search',
                  icon: Icons.search,
                  onTap: () async {
                    var temp = await searchFoods();
                    if (temp != null) {
                      setState(() {
                        refresh(temp);
                      });
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void refresh(Food? f) {
    food = (f != null) ? f : Food();
    if (thisId.isEmpty) thisId = food.id;
  }

  void cpsFresh() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        food.setCaloriesPerServing();
        refresh(food);
      });
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      food.setId(thisId);
      Get.find<FoodX>().saveItem(food);
      Get.back();
    }
  }
}
