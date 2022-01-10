import 'package:flutter/material.dart';
import 'package:jeehbs/models/f_paras.dart';
import 'package:jeehbs/utils.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(this.output, this.objKey, this.paras, {Key? key})
      : super(key: key);
  final Map<String, dynamic> output;
  final FParas paras;
  final String objKey;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: (output[objKey] ?? "").toString(),
      validator: (v) => _validator(v, paras),
      keyboardType: _keyboardType(paras),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(paras.label ?? objKey),
        helperText: (!paras.isNullable) ? '* Required' : null,
      ),
      onSaved: (v) => output[objKey] = _onSaved(v, paras),
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
}
