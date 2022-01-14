import 'package:flutter/material.dart';
import 'package:jeehbs/utils/utils.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(this.paras, {Key? key}) : super(key: key);
  final MyFieldParameters paras;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: UniqueKey(),
      autofocus: paras.autoFocus,
      initialValue: (paras.initValue ?? '').toString(),
      validator: (v) => _validator(v, paras),
      keyboardType: _keyboardType(paras),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction:
          (paras.onFieldSubmitted == null) ? TextInputAction.next : null,
      onFieldSubmitted: paras.onFieldSubmitted,
      decoration: InputDecoration(
        label: Text(paras.label ?? propertyToName(paras.objKey)),
        helperText: _helperText(paras),
        suffixIcon: paras.suffixIcon,
      ),
      onSaved: (v) => paras.whenSaved(v),
    );
  }

  String? _helperText(MyFieldParameters paras) {
    String? retVal = paras.helperText;
    if (retVal == null && !paras.isNullable) retVal = '* Required';
    return retVal;
  }

  TextInputType? _keyboardType(MyFieldParameters paras) {
    switch (paras.type) {
      case MyFieldType.int:
        return TextInputType.number;
      default:
        return null;
    }
  }

  String? _validator(String? value, MyFieldParameters paras) {
    String? retVal;
    if (!paras.isNullable) {
      //Can NOT be null
      switch (paras.type) {
        case MyFieldType.int:
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
        case MyFieldType.int:
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
