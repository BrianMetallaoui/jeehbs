import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/constants/constants.dart';
import 'package:jeehbs/controllers/controllers.dart';
import 'package:jeehbs/widgets/widgets.dart';

import 'components/food_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: body(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RoutePath.foodForm),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BotNavBar(),
    );
  }

  Widget body() => GetBuilder<FoodX>(
        builder: (conX) => Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: conX.items.map((e) => FoodTile(e)).toList(),
            ),
          ),
        ),
      );
}
