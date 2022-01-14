import 'package:flutter/material.dart';

class ExpandedRow extends StatelessWidget {
  const ExpandedRow({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children.map((e) => Expanded(child: e)).toList(),
    );
  }
}
