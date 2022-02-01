import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/models/ingredient.dart';

Future<Ingredient?> showIngredient([Ingredient? ingredient]) {
  final _formKey = GlobalKey<FormState>();
  var i = (ingredient != null) ? ingredient : Ingredient();
  return Get.dialog<Ingredient>(
    AlertDialog(
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                        onSaved: (v) => i.name = v ?? '',
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
            ],
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            _formKey.currentState!.save();
            Get.back(result: i);
          },
          child: const Text('Save'),
        ),
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Get.back(),
        ),
      ],
    ),
  );
}
