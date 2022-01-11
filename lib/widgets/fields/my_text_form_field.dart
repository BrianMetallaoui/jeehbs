import 'package:flutter/material.dart';
import 'package:jeehbs/models/f_paras.dart';
import 'package:jeehbs/utils/checks.dart';

class MyTextFormField<T> extends StatelessWidget {
  const MyTextFormField(
    this.paras, {
    Key? key,
    this.helperText,
  }) : super(key: key);
  final FParas paras;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: UniqueKey(),
      initialValue: (paras.initValue ?? '').toString(),
      validator: (v) => _validator(v, paras),
      keyboardType: _keyboardType(paras),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(paras.label ?? paras.objKey),
        helperText: _helperText(paras),
      ),
      onSaved: (v) => paras.whenSaved(v),
    );
  }

  String? _helperText(FParas paras) {
    String? retVal = helperText ?? paras.helperText;
    if (retVal == null && !paras.isNullable) retVal = '* Required';
    return retVal;
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
}
