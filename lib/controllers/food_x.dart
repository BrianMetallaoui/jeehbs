import 'package:jeehbs/controllers/base_x.dart';
import 'package:jeehbs/models/models.dart';
import 'package:jeehbs/repositories/food_repository.dart';

class FoodX extends BaseXController<Food> {
  FoodX(FoodRepository repository) : super(repository);
  List<Food> get foods => items;
}
