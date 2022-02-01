import 'package:flutter/material.dart';

class BotNavButton extends StatelessWidget {
  const BotNavButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String label;
  final IconData icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            Text(
              label,
              style: Theme.of(context).primaryTextTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}
