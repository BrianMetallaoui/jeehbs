import 'package:jeehbs/my_fields/my_field_parameters.dart';

import '../utils/checks.dart';

dynamic mySave(String? newValue, MyFieldType type) {
  dynamic retVal = newValue;
  switch (type) {
    case MyFieldType.int:
      retVal = intCheck(newValue) ? int.parse(newValue ?? '0') : null;
      break;
    default:
  }
  return retVal;
}
