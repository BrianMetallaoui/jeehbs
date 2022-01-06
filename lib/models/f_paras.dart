import 'package:flutter/material.dart';

Widget field(output, String key, FParas paras) {
  Widget retVal = Text(paras.label ?? key);
  switch (paras.field) {
    case FField.textbox:
      retVal = TextFormField(
        initialValue: (output[key] ?? "").toString(),
        validator: (v) => _validator(v, paras),
        keyboardType: _keyboardType(paras),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(paras.label ?? key),
          helperText: (!paras.isNullable) ? '* Required' : null,
        ),
        onSaved: (v) => output[key] = _onSaved(v, paras),
      );
      break;
    case FField.checkbox:
      retVal = StatefulBuilder(
        builder: (thisLowerContext, sState) => CheckboxListTile(
          value: output[key] ?? false,
          onChanged: (v) => sState(() => output[key] = v),
          title: Text(paras.label ?? key),
        ),
      );
      break;
  }
  return Padding(
    padding: const EdgeInsets.all(8.0),
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

String? _validator(String? value, FParas paras) {
  String? retVal;
  if (!paras.isNullable) {
    //Can NOT be null
    switch (paras.type) {
      case FType.int:
        retVal = !intCheck(value)
            ? paras.validatorText ?? 'Please enter valid number'
            : null;
        break;
      default:
        retVal = !strCheck(value)
            ? paras.validatorText ?? 'Please enter some text'
            : null;
    }
  } else if (strCheck(value)) {
    //Can be null but check if the value is correct
    switch (paras.type) {
      case FType.int:
        retVal = !intCheck(value)
            ? paras.validatorText ?? 'Please enter valid number or no value'
            : null;
        break;
      default:
    }
  }
  return retVal;
}

dynamic _onSaved(String? newValue, FParas paras) {
  dynamic retVal = newValue;
  switch (paras.type) {
    case FType.int:
      retVal = intCheck(newValue) ? int.parse(newValue ?? '0') : null;
      break;
    default:
  }
  return retVal;
}

bool intCheck(val) => int.tryParse(val ?? '') != null;
bool strCheck(val) => !(val == null || val.isEmpty);

class FParas {
  FType type;
  FField field;
  String? label;
  bool isNullable;
  String? validatorText;

  FParas({
    required this.type,
    this.field = FField.textbox,
    this.isNullable = false,
    this.label,
    this.validatorText,
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
