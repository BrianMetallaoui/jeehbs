class FParas {
  FType type;
  FField field;
  String? label;
  bool isNullable;
  String? validatorText;
  String? helperText;
  dynamic initValue;
  Function whenSaved;

  FParas({
    required this.type,
    required this.initValue,
    required this.whenSaved,
    this.field = FField.textbox,
    this.isNullable = false,
    this.label,
    this.validatorText,
    this.helperText,
  });
}

enum FType {
  string,
  int,
  bool,
}
enum FField {
  textbox,
  checkbox,
}
