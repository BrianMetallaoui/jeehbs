import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeehbs/models/f_paras.dart';
import 'package:jeehbs/main_x.dart';

import 'models/person.dart';

class PersonForm extends StatelessWidget {
  const PersonForm({Key? key, this.person}) : super(key: key);
  final Person? person;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    Map<String, dynamic> model = (person != null) ? person!.toMap() : {};
    Widget f(String key) => field(model, key, Person.fields[key]!);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: GetBuilder<MainX>(
          builder: (conX) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    f(Person.nameField),
                    Row(
                      children: [
                        Expanded(child: f(Person.ageField)),
                        Expanded(child: f(Person.isCoolField)),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    conX.add(model);
                    Get.back();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
