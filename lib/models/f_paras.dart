class FParas {
  FType type;
  FField field;
  String? label;
  bool isNullable;
  String? validatorText;

  FParas({
    required this.type,
    this.field = FField.textbox,
    this.isNullable = false,
    this.label,
    this.validatorText,
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
