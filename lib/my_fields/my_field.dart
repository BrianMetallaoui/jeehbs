import 'package:flutter/material.dart';
import 'package:jeehbs/my_fields/f_paras.dart';
import 'package:jeehbs/my_fields/my_checkbox.dart';
import 'package:jeehbs/my_fields/my_text_form_field.dart';

Widget myField(
  FParas paras, {
  String? helperText,
}) {
  Widget retVal = Text(paras.label ?? paras.objKey);
  switch (paras.field) {
    case FField.textbox:
      retVal = MyTextFormField(paras, helperText: helperText);
      break;
    case FField.checkbox:
      retVal = MyCheckbox(paras);
      break;
  }
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: retVal,
  );
}
