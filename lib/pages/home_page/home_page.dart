import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/constants/constants.dart';
import 'package:jeehbs/controllers/controllers.dart';

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
                children: conX.items.map((e) => FoodTile(e)).toList(),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.toNamed(RoutePath.foodForm),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
