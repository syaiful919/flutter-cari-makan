import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/food_model.dart';
import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/model/response/food_response_model.dart';
import 'package:carimakan/model/response/user_response_model.dart';

import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/utils/project_exception.dart';
import 'package:stacked/stacked.dart';

import 'package:carimakan/repository/food_repository.dart';
import 'package:carimakan/repository/user_repository.dart';

class HomeViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _foodRepo = locator<FoodRepository>();
  final _userRepo = locator<UserRepository>();

  List<FoodModel> foods;
  UserModel user;
  String userToken;

  Future<void> firstLoad() async {
    // _userRepo.saveUserToken('4385|E33ZzaKrl29fHqSt9YwZ18LGRuFnRiq7soKWL1lR');
    _userRepo.saveUserToken('4388|cKqDF8MDNHDOs9glIPBNbUaJ8kthFx5c6NwEXTt3');

    runBusyFuture(getFood());
    await getUserToken();
    if (userToken != null) runBusyFuture(getUserData());
  }

  Future<void> getUserToken() async {
    try {
      userToken = _userRepo.getUserToken();
    } catch (e) {
      print(">>> get user token error: $e");
    }
  }

  Future<void> getUserData() async {
    try {
      UserResponseModel result =
          await _userRepo.getUserDataRemote(token: userToken);
      if (result.data != null) {
        user = result.data;
        _userRepo.setIsLogin(true);
      }
    } on UnauthorizedException {
      _userRepo.setIsLogin(false);
    } catch (e) {
      print(">>> get user error: $e");
    }
  }

  Future<void> getFood() async {
    try {
      FoodResponseModel result = await _foodRepo.getFood();
      if (result.data.foods.length > 0) {
        foods = result.data.foods;
      }
    } catch (e) {
      print(">>> get food error: $e");
    }
  }

  void goBack() => _nav.pop();
}
