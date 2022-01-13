class MyFieldParameters {
  MyFieldType type;
  MyFieldControl control;
  String objKey;
  String? label;
  bool isNullable;
  String? validatorText;
  String? helperText;
  dynamic initValue;
  Function whenSaved;

  MyFieldParameters({
    required this.type,
    required this.initValue,
    required this.whenSaved,
    required this.objKey,
    this.control = MyFieldControl.textbox,
    this.isNullable = false,
    this.label,
    this.validatorText,
    this.helperText,
  });
}

enum MyFieldType {
  string,
  int,
  bool,
}
enum MyFieldControl {
  textbox,
  checkbox,
}
