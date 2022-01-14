import 'package:flutter/material.dart';

class BotNavBar extends StatelessWidget {
  const BotNavBar({Key? key, this.items}) : super(key: key);
  final List<Widget>? items;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = items ?? [];
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 12,
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            const SizedBox(width: 10),
            ...widgets,
          ],
        ),
      ),
    );
  }
}
