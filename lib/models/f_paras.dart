import 'package:flutter/material.dart';

Widget field(output, String key, FParas paras) {
  Widget retVal = Text('${paras.label ?? key}');
  switch (paras.field) {
    case FField.textbox:
      retVal = TextFormField(
        initialValue: (output[key] ?? "").toString(),
        validator: (v) => _validator(v, paras),
        keyboardType: _keyboardType(paras),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text('${paras.label ?? key}'),
          helperText: (paras.required) ? '* Required' : null,
        ),
        onSaved: (v) => output[key] = _onSaved(v, paras),
      );
      break;
    case FField.checkbox:
      retVal = StatefulBuilder(
        builder: (thisLowerContext, sState) => CheckboxListTile(
          value: output[key] ?? false,
          onChanged: (v) => sState(() => output[key] = v),
          title: Text('${paras.label ?? key}'),
        ),
      );
      break;
  }
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: retVal,
  );
}

TextInputType? _keyboardType(FParas paras) {
  switch (paras.type) {
    case FType.int:
      return TextInputType.number;
    default:
      return null;
  }
}

String? _validator(value, FParas paras) {
  if (paras.required) {
    switch (paras.type) {
      case FType.int:
        if (!(int.tryParse(value ?? '') != null)) {
          return 'Please enter valid number';
        }
        return null;
      default:
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
    }
  }
  return null;
}

dynamic _onSaved(newValue, FParas paras) {
  dynamic retVal = newValue;
  switch (paras.type) {
    case FType.int:
      retVal = int.parse(newValue ?? '0');
      break;
    default:
  }
  return retVal;
}

class FParas {
  FType type;
  FField field;
  String? label;
  bool required;

  FParas({
    required this.type,
    this.field = FField.textbox,
    this.required = false,
    this.label,
  });
}

enum FType {
  string,
  int,
  bool,
}
enum FField {
  textbox,
  checkbox,
}
