import 'package:flutter/material.dart';
import 'package:jeehbs/models/f_paras.dart';

class MyCheckbox extends StatefulWidget {
  const MyCheckbox(this.output, this.objKey, this.paras, {Key? key})
      : super(key: key);
  final Map<String, dynamic> output;
  final FParas paras;
  final String objKey;

  @override
  _MyCheckboxState createState() => _MyCheckboxState();
}

class _MyCheckboxState extends State<MyCheckbox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      key: UniqueKey(),
      value: widget.output[widget.objKey] ?? false,
      onChanged: (v) => setState(() => widget.output[widget.objKey] = v),
      title: Text(widget.paras.label ?? widget.objKey),
    );
  }
}
