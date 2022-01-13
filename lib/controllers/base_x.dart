import 'package:get/get.dart';
import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/data/data.dart';

class BaseXController<T extends BaseModel> extends GetxController {
  final BaseRepository<T> repository;
  List<T> items = [];

  BaseXController(this.repository) {
    loadItems();
  }

  void loadItems() {
    items = repository.loadItems();
    update();
  }

  void saveItem(T item) {
    var x = items.indexWhere((i) => i.id == item.id);
    if (x > -1) {
      items[x] = item;
    } else {
      items.add(item);
    }
    repository.saveListToDisk(items);
    update();
  }

  void deleteItem(T item) {
    items.remove(item);
    repository.saveListToDisk(items);
    update();
  }
}
