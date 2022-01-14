import 'package:flutter/material.dart';

class BotNavItem extends StatelessWidget {
  const BotNavItem({
    Key? key,
    this.onClick,
    this.icon,
    this.label = '',
  }) : super(key: key);
  final String label;
  final IconData? icon;
  final Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 60.0,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onClick,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Icon(icon), Text(label)],
            ),
          ),
        ),
      ),
    );
  }
}
