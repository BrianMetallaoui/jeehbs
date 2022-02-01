import 'package:flutter/material.dart';
import 'package:jeehbs/models/ingredient.dart';

class IngredientGrid extends StatelessWidget {
  const IngredientGrid({
    Key? key,
    required this.ingredients,
    required this.onTap,
    required this.delete,
  }) : super(key: key);
  final List<Ingredient> ingredients;
  final Function(Ingredient) onTap;
  final Function(Ingredient) delete;

  @override
  Widget build(BuildContext context) {
    List<List<Widget>> rows = [[]];
    var perRow = 2;

    for (var i = 0; i < ingredients.length; i++) {
      if (i % perRow == 0) rows.add([]);
      var ing = ingredients[i];

      var name = Text(ing.name);
      var stats = Wrap(
        children: [
          Text(
            '${ing.amount * (ing.calories ?? 0)}: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Cal: ${ing.calories} Amt: ${ing.amount}',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      );
      var button = IconButton(
        onPressed: () => delete(ing),
        icon: const Icon(
          Icons.remove,
          color: Colors.red,
        ),
      );
      rows.last.add(
        Expanded(
          child: GestureDetector(
            onTap: () => onTap(ing),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [Expanded(child: name), button]),
                    stats
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    while (rows.last.length % perRow != 0) {
      rows.last.add(
        Expanded(child: Container()),
      );
    }

    return Column(
      children: rows.map((e) => Row(children: e)).toList(),
    );
  }
}
