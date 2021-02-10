import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/food_model.dart';
import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/model/response/food_response_model.dart';
import 'package:carimakan/model/response/user_response_model.dart';

import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:carimakan/utils/project_exception.dart';
import 'package:stacked/stacked.dart';

import 'package:carimakan/repository/food_repository.dart';
import 'package:carimakan/repository/user_repository.dart';

class HomeViewModel extends StreamViewModel {
  final _nav = locator<NavigationService>();
  final _foodRepo = locator<FoodRepository>();
  final _userRepo = locator<UserRepository>();

  List<FoodModel> foods;
  UserModel user;
  String userToken;

  @override
  Stream get stream => _userRepo.isLogin;

  @override
  void onData(data) {
    super.onData(data);
    if (!data && user != null) clearUser();
    if (data && user == null) getUserData();
  }

  Future<void> firstLoad() async {
    runBusyFuture(getFood());
  }

  void clearUser() {
    user = null;
    notifyListeners();
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
      if (userToken == null) await getUserToken();
      print(">>> token $userToken");
      UserResponseModel result =
          await _userRepo.getUserDataRemote(token: userToken);
      if (result?.data != null) {
        user = result.data;
        _userRepo.saveUserData(user);
      } else {
        user = _userRepo.getUserData();
      }
    } on UnauthorizedException {
      _userRepo.setIsLogin(false);
      clearUser();
    } catch (e) {
      print(">>> get user error: $e");
    } finally {
      notifyListeners();
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

  void goToFoodDetail(FoodModel food) {
    _nav.pushNamed(
      Routes.foodDetailPage,
      arguments: FoodDetailPageArguments(food: food),
    );
  }
}
