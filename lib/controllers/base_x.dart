import 'package:get/get.dart';
import 'package:jeehbs/data/base_repository.dart';
import 'package:jeehbs/models/base_model.dart';

class BaseXController<T extends BaseModel> extends GetxController {
  final BaseRepository<T> repository;
  List<T> items = [];

  BaseXController(this.repository) {
    loadItems();
    repository.listen(loadItems);
  }

  void loadItems() {
    items = repository.loadAllItems();
    update();
  }

  void saveItem(T item) {
    repository.saveItem(item);
  }

  void deleteItem(T item) {
    repository.removeItem(item);
  }
}
