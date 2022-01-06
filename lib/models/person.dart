import 'dart:convert';

import 'package:jeehbs/models/f_paras.dart';

class Person {
  String? name;
  int? age;
  bool isCool;
  Person({
    this.name,
    this.age,
    this.isCool = false,
  });

  static Map<String, FParas> fields = {
    'name': FParas(type: FType.string, required: true),
    'age': FParas(type: FType.int),
    'isCool': FParas(type: FType.bool, field: FField.checkbox),
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
