import 'package:jeehbs/my_fields/f_paras.dart';

import '../utils/checks.dart';

dynamic mySave(String? newValue, FType type) {
  dynamic retVal = newValue;
  switch (type) {
    case FType.int:
      retVal = intCheck(newValue) ? int.parse(newValue ?? '0') : null;
      break;
    default:
  }
  return retVal;
}
