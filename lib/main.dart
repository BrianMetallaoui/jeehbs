import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/main_x.dart';
import 'package:jeehbs/person_form.dart';

void main() {
  Get.put(MainX());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: GetBuilder<MainX>(
          builder: (conX) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ...conX.persons
                  .map(
                    (e) => ListTile(
                      leading: (e.isCool) ? Text('X') : null,
                      title: Text(e.name!),
                      trailing: Text(e.age!.toString()),
                      onTap: () => Get.to(PersonForm(p: e)),
                    ),
                  )
                  .toList(),
              ElevatedButton(
                onPressed: () => Get.to(PersonForm()),
                child: Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
