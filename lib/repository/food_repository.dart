import 'package:carimakan/model/response/food_response_model.dart';
import 'package:carimakan/network/api/food_api.dart';

class FoodRepository {
  final FoodApi _api = FoodApi();

  Future<FoodResponseModel> getFood() => _api.getFood();
}
