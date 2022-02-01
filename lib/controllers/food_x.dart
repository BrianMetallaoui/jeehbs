import 'package:jeehbs/controllers/base_x.dart';
import 'package:jeehbs/data/food_repository.dart';
import 'package:jeehbs/models/food.dart';

class FoodX extends BaseXController<Food> {
  FoodX(FoodRepository repository) : super(repository);
  List<Food> get foods => items;
}
