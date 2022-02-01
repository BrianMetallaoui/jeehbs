import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/data/foods.dart';
import 'package:jeehbs/models/food.dart';

Future<Food?> searchFoods() async {
  return Get.dialog<Food>(
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
        onSelected: (Food s) => Get.back(result: s.clone()),
        displayStringForOption: (option) => option.name,
      ),
    ),
  );
}
