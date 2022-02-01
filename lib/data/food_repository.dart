import 'package:get_storage/get_storage.dart';
import 'package:jeehbs/models/food.dart';

import 'base_repository.dart';

class FoodRepository extends BaseRepository<Food> {
  FoodRepository() : super(box: GetStorage(), convertJsonToItem: Food.fromJson);
}
