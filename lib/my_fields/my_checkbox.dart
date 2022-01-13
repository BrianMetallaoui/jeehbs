import 'package:flutter/material.dart';
import 'package:jeehbs/my_fields/f_paras.dart';

class MyCheckbox extends StatefulWidget {
  const MyCheckbox(this.paras, {Key? key}) : super(key: key);
  final FParas paras;

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  bool val = false;
  @override
  void initState() {
    val = widget.paras.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      key: UniqueKey(),
      value: val,
      onChanged: (v) => setState(() {
        val = v ?? false;
        widget.paras.whenSaved(val);
      }),
      title: Text(widget.paras.label ?? widget.paras.objKey),
    );
  }
}
