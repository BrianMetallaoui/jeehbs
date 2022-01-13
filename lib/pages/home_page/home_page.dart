import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/controllers/food_x.dart';
import 'package:jeehbs/pages/food_form/food_form.dart';

import 'components/food_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodX>(
      builder: (conX) {
        return Scaffold(
          appBar: AppBar(title: const Text('Home')),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ...conX.items.map((e) => FoodTile(e)).toList(),
                  ElevatedButton(
                    onPressed: () => Get.to(() => const FoodForm()),
                    child: const Text('Add Food'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
