import 'package:jeehbs/constants/constants.dart';
import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/repositories/base_repository.dart';

class FoodRepository extends BaseRepository<Food> {
  FoodRepository()
      : super(
          boxItemsKey: BoxKey.foods,
          convertJsonToItem: Food.fromJson,
        );
}
