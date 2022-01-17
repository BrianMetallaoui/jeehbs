import 'package:get_storage/get_storage.dart';
import 'package:jeehbs/constants/constants.dart';
import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/data/data.dart';

class FoodRepository extends BaseRepository<Food> {
  FoodRepository()
      : super(box: GetStorage(BoxId.foods), convertJsonToItem: Food.fromJson);
}
