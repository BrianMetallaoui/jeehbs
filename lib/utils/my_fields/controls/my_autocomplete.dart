import 'package:flutter/material.dart';
import 'package:jeehbs/models/base_model.dart';

class MyAutocomplete<T extends BaseModel> extends StatelessWidget {
  const MyAutocomplete(this.items, this.onSelect, {Key? key}) : super(key: key);
  final List<T> items;
  final Function(T selection) onSelect;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
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
            decoration: const InputDecoration(label: Text('Search')),
            focusNode: focusNode,
            controller: textEditingController,
            onFieldSubmitted: (String value) => onFieldSubmitted(),
            autofocus: true,
          ),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return [];
        }
        return items.where(
          (T option) => (option.name)
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase()),
        );
      },
      onSelected: onSelect,
      displayStringForOption: (option) => option.name,
    );
  }
}
