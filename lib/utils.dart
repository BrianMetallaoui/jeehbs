bool intCheck(val) => int.tryParse(val ?? '') != null;
bool strCheck(val) => !(val == null || val.isEmpty);
