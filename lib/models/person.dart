import 'dart:convert';

import 'package:jeehbs/models/f_paras.dart';

class Person {
  String name;
  int? age;
  bool isCool;
  Person({
    required this.name,
    this.age,
    this.isCool = false,
  });

  static String nameField = 'name';
  static String ageField = 'age';
  static String isCoolField = 'isCool';
  static Map<String, FParas> fields = {
    nameField: FParas(type: FType.string),
    ageField: FParas(type: FType.int, isNullable: true),
    isCoolField: FParas(type: FType.bool, field: FField.checkbox),
  };

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'isCool': isCool,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      name: map['name'],
      age: map['age']?.toInt(),
      isCool: map['isCool'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source));
}
