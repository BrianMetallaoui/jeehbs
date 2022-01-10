import 'dart:convert';

import 'package:uuid/uuid.dart';

class BaseModel {
  String _id;

  BaseModel([String? id]) : _id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {'id': _id};
  }

  String get id => _id;

  factory BaseModel.fromMap(Map<String, dynamic> map) {
    return BaseModel(map['id']);
  }

  String toJson() => json.encode(toMap());

  factory BaseModel.fromJson(String source) =>
      BaseModel.fromMap(json.decode(source));
}
