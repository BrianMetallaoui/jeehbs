import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/repositories/base_repository.dart';

class FoodRepository extends BaseRepository<Food> {
  FoodRepository() : super(boxItemsKey: 'FOOD', convert: Food.fromJson);
}
