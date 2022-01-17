import 'package:get_storage/get_storage.dart';

import 'package:jeehbs/models/models.dart';

class BaseRepository<T extends BaseModel> {
  GetStorage box;
  T Function(String) convertJsonToItem;

  BaseRepository({required this.box, required this.convertJsonToItem});

  void listen(void Function() value) {
    box.listen(value);
  }

  void saveItem(T item) {
    box.write(item.id, item.toJson());
  }

  T? loadItem(String itemId) {
    T? retVal;
    var temp = box.read(itemId);
    if (temp != null) retVal = convertJsonToItem(temp);
    return retVal;
  }

  void removeItem(T item) {
    box.remove(item.id);
  }

  void saveAllItems(List<T> items) {
    for (var item in items) {
      box.write(item.id, item.toJson());
    }
  }

  List<T> loadAllItems() {
    return (box.getValues() ?? []).map<T>((e) => convertJsonToItem(e)).toList();
  }

  void removeAllItems() {
    box.erase();
  }
}
