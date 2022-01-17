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
  late Map<String, MyFieldParameters> fields;

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
    return Scaffold(
      appBar: AppBar(
        title: Text((editing) ? 'Edit ${model.name}' : 'Add Food'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        myField(fields[Food.nameField]!),
                        ExpandedRow(
                          children: [
                            myField(
                              (fields[Food.caloriesPerServingField]!)
                                ..helperText = cps
                                ..onFieldSubmitted = (v) => _save(),
                            ),
                            myField(fields[Food.totalCaloriesField]!),
                            myField(
                              (fields[Food.servingsField]!)
                                ..suffixIcon = IconButton(
                                  icon: const Icon(Icons.refresh),
                                  onPressed: cpsFresh,
                                )
                                ..onFieldSubmitted = (_) => cpsFresh(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: model.ingredients.map((e) {
                        Map<String, MyFieldParameters> fields = e.fields();
                        return ExpandedRow(
                          children: [
                            myField(fields[Ingredient.nameField]!),
                            myField(fields[Ingredient.caloriesField]!),
                            myField(fields[Ingredient.amountField]!),
                            myField(
                              (fields[Ingredient.servingSizeField]!)
                                ..onFieldSubmitted = (_) => cpsFresh(),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
              onClick: () => Get.bottomSheet(Container()),
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
    );
  }

  void refresh(Food? f) {
    model = (f != null) ? f : Food();
    fields = model.fields();
    if (thisId.isEmpty) thisId = model.id;
  }

  String get cps => 'Normal amount: ${model.calucateTotalCalories}';

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
}
