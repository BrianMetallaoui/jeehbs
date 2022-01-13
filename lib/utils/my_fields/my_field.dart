import 'package:flutter/material.dart';
import 'package:jeehbs/utils/utils.dart';

Widget myField(MyFieldParameters paras, {String? helperText}) {
  Widget retVal = Text(paras.label ?? paras.objKey);
  switch (paras.control) {
    case MyFieldControl.textbox:
      retVal = MyTextFormField(paras, helperText: helperText);
      break;
    case MyFieldControl.checkbox:
      retVal = MyCheckbox(paras);
      break;
  }
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: retVal,
  );
}
