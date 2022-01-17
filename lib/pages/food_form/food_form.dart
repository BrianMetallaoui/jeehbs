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
  Ingredient editingIngredient = Ingredient();

  var editing = false;
  late String thisId;
  late FocusNode searchFocusNode;
  late TextEditingController searchTextEditingController;

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
            tabs: [Text('Info'), Text('Recipe')],
            indicatorColor: Colors.white,
            labelPadding: EdgeInsets.all(12.0),
          ),
        ),
        body: Form(
          key: _formKey,
          child: TabBarView(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Ingredients'),
                        Expanded(
                          child: SingleChildScrollView(
                            child: ingredientGrid(model.ingredients),
                          ),
                        )
                      ],
                    ),
                  ),
                  Autocomplete<Food>(
                    fieldViewBuilder: (
                      context,
                      textEditingController,
                      focusNode,
                      onFieldSubmitted,
                    ) {
                      searchFocusNode = focusNode;
                      searchTextEditingController = textEditingController;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          key: UniqueKey(),
                          decoration:
                              const InputDecoration(label: Text('Search')),
                          focusNode: focusNode,
                          controller: textEditingController,
                          onFieldSubmitted: (String value) =>
                              onFieldSubmitted(),
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
                      searchTextEditingController.clear();
                    }),
                    displayStringForOption: (option) => option.name,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text('General'),
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
                                  onSaved: (v) => model.name =
                                      mySave(v, MyFieldType.string),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${model.calucateCalories}'),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
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
                                    onSaved: (v) => model.servings =
                                        int.tryParse(v ?? '') ?? 1,
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
                                    initialValue: editingIngredient.name,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      label: Text('Name'),
                                    ),
                                    onSaved: (v) => editingIngredient.name =
                                        mySave(v, MyFieldType.string),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    key: UniqueKey(),
                                    initialValue:
                                        (editingIngredient.amount).toString(),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      label: Text('Amount'),
                                    ),
                                    onSaved: (v) => editingIngredient.amount =
                                        int.tryParse(v ?? '') ?? 0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    key: UniqueKey(),
                                    initialValue:
                                        (editingIngredient.calories ?? '')
                                            .toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      label: Text('Calories'),
                                    ),
                                    onSaved: (v) => editingIngredient.calories =
                                        int.tryParse(v ?? '') ?? 0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _formKey.currentState!.save();

                                      model.ingredients.add(editingIngredient);
                                      editingIngredient = Ingredient();
                                      setState(() {
                                        refresh(model);
                                      });
                                    },
                                    child: const Text('Add'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BotNavItem(
                onClick: () => Get.back(),
                icon: Icons.cancel,
                label: 'Cancel',
              ),
              BotNavItem(
                onClick: () => searchFocusNode.requestFocus(),
                icon: Icons.search,
                label: 'Search',
              ),
              BotNavItem(
                onClick: _save,
                icon: Icons.save,
                label: 'Save',
              ),
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

  Widget iCard(Ingredient i) {
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          _formKey.currentState!.save();
          setState(() {
            editingIngredient = i;
          });
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      i.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      (i.amount * (i.calories ?? 0)).toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  'Cal: ${i.calories}   Amt: ${i.amount}',
                  style: const TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ingredientGrid(List<Ingredient> ingredients) {
    List<List<Widget>> rows = [[]];
    var length = 3;

    for (var i in ingredients) {
      if (rows.last.length == length) {
        rows.add([]);
      }
      rows.last.add(iCard(i));
    }
    while (rows.last.length < length) {
      rows.last.add(Container());
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: rows.map((e) => ExpandedRow(children: e)).toList(),
    );
  }
}
