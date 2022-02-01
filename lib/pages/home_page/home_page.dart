import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/controllers/food_x.dart';
import 'package:jeehbs/pages/food_form/food_form.dart';
import 'package:jeehbs/widgets/widgets.dart';

import 'components/food_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: GetBuilder<FoodX>(
        builder: (conX) => Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: conX.items.map((e) => FoodTile(e)).toList(),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const FoodForm()),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BotNavBar(),
    );
  }
}
