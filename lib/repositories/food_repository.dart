import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/repositories/base_repository.dart';

class FoodRepository extends BaseRepository<Food> {
  static String boxItemsKeyValue = 'FOOD';
  FoodRepository()
      : super(
          boxItemsKey: boxItemsKeyValue,
          convertJsonToItem: Food.fromJson,
        );
}
