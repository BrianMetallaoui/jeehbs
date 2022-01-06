import 'package:get/get.dart';
import 'package:jeehbs/models/person.dart';

class MainX extends GetxController {
  List<Person> persons = [];

  add(Map<String, dynamic> input) {
    try {
      persons.add(Person.fromMap(input));
      update();
    } catch (e) {
      print(e);
    }
  }
}
