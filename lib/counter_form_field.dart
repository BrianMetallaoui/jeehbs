import 'package:flutter/material.dart';

class CounterFormField extends FormField<int> {
  CounterFormField({
    FormFieldSetter<int>? onSaved,
    FormFieldValidator<int>? validator,
    int initialValue = 0,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (FormFieldState<int> state) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    state.didChange(state.value! - 1);
                  },
                ),
                Text(state.value.toString()),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    state.didChange(state.value! + 1);
                  },
                ),
              ],
            );
          },
        );
}
