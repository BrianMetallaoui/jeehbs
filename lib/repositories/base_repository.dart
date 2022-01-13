import 'package:get_storage/get_storage.dart';

import 'package:jeehbs/models/models.dart';

class BaseRepository<T extends BaseModel> {
  String boxItemsKey;
  GetStorage box = GetStorage();
  T Function(String) convert;

  BaseRepository({required this.boxItemsKey, required this.convert});

  void saveListToDisk(List<T> items) {
    box.write(boxItemsKey, items.map((i) => i.toJson()).toList());
  }

  List<T> loadItems() {
    return (box.read<List>(boxItemsKey) ?? []).map((e) => convert(e)).toList();
  }
}
