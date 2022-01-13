import 'package:flutter/material.dart';

class CounterFormField extends FormField<int> {
  CounterFormField({
    Key? key,
    FormFieldSetter<int>? onSaved,
    FormFieldValidator<int>? validator,
    int initialValue = 0,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<int> state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    state.didChange(state.value! - 1);
                  },
                ),
                Text(state.value.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    state.didChange(state.value! + 1);
                  },
                ),
              ],
            );
          },
        );
}
