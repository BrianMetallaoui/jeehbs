import 'package:flutter/material.dart';
import 'package:jeehbs/models/f_paras.dart';
import 'package:jeehbs/widgets/fields/my_checkbox.dart';
import 'package:jeehbs/widgets/fields/my_text_form_field.dart';

Widget myField(
  Map<String, dynamic> output,
  String objKey,
  FParas paras, {
  String? helperText,
}) {
  Widget retVal = Text(paras.label ?? objKey);
  switch (paras.field) {
    case FField.textbox:
      retVal = MyTextFormField(output, objKey, paras, helperText: helperText);
      break;
    case FField.checkbox:
      retVal = MyCheckbox(output, objKey, paras);
      break;
  }
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: retVal,
  );
}
