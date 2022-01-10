import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/controllers/main_x.dart';
import 'package:jeehbs/pages/forms/food_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: GetBuilder<MainX>(
          builder: (conX) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                ...conX.foods
                    .map(
                      (e) => ListTile(
                        title: Text(e.name),
                        subtitle: Text(e.servings.toString()),
                        trailing: Text(e.caloriesPerServing.toString()),
                        onTap: () => Get.to(FoodForm(food: e)),
                      ),
                    )
                    .toList(),
                ElevatedButton(
                  onPressed: () => Get.to(const FoodForm()),
                  child: const Text('Add Food'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
