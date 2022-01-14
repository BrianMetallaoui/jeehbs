import 'dart:convert';

import 'package:uuid/uuid.dart';

class BaseModel {
  String _id;
  String name;

  BaseModel(this.name, [String? id]) : _id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {'name': name, 'id': _id};
  }

  String get id => _id;

  void newId() {
    _id = const Uuid().v4();
  }

  void setId(String newId) {
    _id = newId;
  }

  bool isEqual(BaseModel? model) {
    return id == model?.id;
  }

  factory BaseModel.fromMap(Map<String, dynamic> map) {
    return BaseModel(map['name'], map['id']);
  }

  String toJson() => json.encode(toMap());

  factory BaseModel.fromJson(String source) =>
      BaseModel.fromMap(json.decode(source));
}
