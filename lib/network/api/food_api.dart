import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/response/food_response_model.dart';
import 'package:carimakan/network/api/http_client_helper.dart';

class FoodApi {
  final _helper = locator<HttpClientHelper>();

  Future<FoodResponseModel> getFood() async {
    var result = await _helper.get(endpoint: "food");
    return FoodResponseModel.fromJson(result);
  }
}
