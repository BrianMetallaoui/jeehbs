import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/constants/constants.dart';
import 'package:jeehbs/controllers/controllers.dart';
import 'package:jeehbs/data/data.dart';
import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/utils/utils.dart';
import 'package:jeehbs/widgets/widgets.dart';

class FoodForm extends StatefulWidget {
  const FoodForm({Key? key}) : super(key: key);

  @override
  State<FoodForm> createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  final _formKey = GlobalKey<FormState>();

  late Food model;

  var editing = false;
  late String thisId;

  @override
  void initState() {
    super.initState();
    var input = Get.arguments?[Argument.food] as Food?;

    thisId = input?.id ?? '';
    editing = (input != null);
    refresh(input);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text((editing) ? 'Edit ${model.name}' : 'Add Food'),
          bottom: const TabBar(
            tabs: [Tab(child: Text('General')), Tab(child: Text('Recipe'))],
          ),
        ),
        body: Form(
          key: _formKey,
          child: TabBarView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ExpandedRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                key: UniqueKey(),
                                initialValue: model.name,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  label: Text('Name'),
                                ),
                                onSaved: (v) =>
                                    model.name = mySave(v, MyFieldType.string),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                key: UniqueKey(),
                                initialValue: (model.servings).toString(),
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  label: Text('Servings'),
                                ),
                                onFieldSubmitted: (v) {
                                  model.servings = int.tryParse(v) ?? 1;
                                  cpsFresh();
                                },
                                onSaved: (v) =>
                                    model.servings = int.tryParse(v ?? '') ?? 1,
                              ),
                            ),
                          ],
                        ),
                        IngredientsForm(
                          food: model,
                          formKey: _formKey,
                          onChange: cpsFresh,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: UniqueKey(),
                        initialValue: model.recipe,
                        keyboardType: TextInputType.multiline,
                        expands: true,
                        maxLines: null,
                        decoration: const InputDecoration(
                          label: Text('Recipe'),
                          alignLabelWithHint: true,
                        ),
                        onSaved: (v) => model.recipe = v ?? '',
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
              BotNavItem(
                label: '${model.calucateCalories}',
              ),
              BotNavItem(
                onClick: showSearch,
                icon: Icons.search,
                label: 'Search',
              ),
              const BotNavItem(label: ''),
            ],
          ),
        ),
      ),
    );
  }

  void refresh(Food? f) {
    model = (f != null) ? f : Food();
    if (thisId.isEmpty) thisId = model.id;
  }

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
      model.setId(thisId);
      Get.find<FoodX>().saveItem(model);
      Get.back();
    }
  }

  void showSearch() {
    Get.dialog(
      AlertDialog(
        content: Autocomplete<Food>(
          fieldViewBuilder: (
            context,
            textEditingController,
            focusNode,
            onFieldSubmitted,
          ) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                key: UniqueKey(),
                autofocus: true,
                decoration: const InputDecoration(label: Text('Search')),
                focusNode: focusNode,
                controller: textEditingController,
                onFieldSubmitted: (String value) => onFieldSubmitted(),
              ),
            );
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return [];
            }
            return foods.where(
              (Food option) => (option.name)
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase()),
            );
          },
          onSelected: (Food s) => setState(() {
            refresh(s.clone());
            Get.back();
          }),
          displayStringForOption: (option) => option.name,
        ),
      ),
    );
  }
}

class IngredientsForm extends StatefulWidget {
  const IngredientsForm({
    Key? key,
    required this.food,
    required this.formKey,
    required this.onChange,
  }) : super(key: key);

  final Food food;
  final GlobalKey<FormState> formKey;
  final Function() onChange;

  @override
  State<IngredientsForm> createState() => _IngredientsFormState();
}

class _IngredientsFormState extends State<IngredientsForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ingredients (${widget.food.ingredients.length})'),
            IconButton(
              onPressed: () async {
                var ing = await showIngredient();
                if (ing != null) {
                  widget.formKey.currentState!.save();

                  setState(() {
                    var existing = widget.food.ingredients
                        .indexWhere((c) => c.id == ing.id);
                    if (existing != -1) {
                      widget.food.ingredients[existing] = ing;
                    } else {
                      widget.food.ingredients.add(ing);
                    }
                  });
                  widget.onChange();
                }
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        ...widget.food.ingredients
            .map(
              (i) => ListTile(
                leading: Text(
                  (i.amount * (i.calories ?? 0)).toString(),
                ),
                title: Text(
                  i.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Cal: ${i.calories}   Amt: ${i.amount}',
                ),
                trailing: IconButton(
                  onPressed: () => setState(() {
                    widget.formKey.currentState!.save();
                    widget.food.ingredients.remove(i);
                  }),
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                ),
                onTap: () async {
                  var ing = await showIngredient(i);
                  if (ing != null) {
                    widget.formKey.currentState!.save();

                    setState(() {
                      var existing = widget.food.ingredients
                          .indexWhere((c) => c.id == ing.id);
                      if (existing != -1) {
                        widget.food.ingredients[existing] = ing;
                      } else {
                        widget.food.ingredients.add(ing);
                      }
                    });
                    widget.onChange();
                  }
                },
              ),
            )
            .toList()
      ],
    );
  }

  Future<Ingredient?> showIngredient([Ingredient? ingredient]) {
    final _formKey = GlobalKey<FormState>();
    var i = (ingredient != null) ? ingredient : Ingredient();
    return Get.dialog<Ingredient>(
      AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: UniqueKey(),
                        initialValue: i.name,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          label: Text('Name'),
                        ),
                        onSaved: (v) => i.name = mySave(v, MyFieldType.string),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: UniqueKey(),
                        initialValue: (i.amount).toString(),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Amount'),
                        ),
                        onSaved: (v) => i.amount = int.tryParse(v ?? '') ?? 0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        key: UniqueKey(),
                        initialValue: (i.calories ?? '').toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Calories'),
                        ),
                        onSaved: (v) => i.calories = int.tryParse(v ?? '') ?? 0,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.save();
                        Get.back(result: i);
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
