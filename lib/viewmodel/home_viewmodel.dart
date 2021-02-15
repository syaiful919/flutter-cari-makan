import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/food_model.dart';
import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/model/response/food_response_model.dart';
import 'package:carimakan/model/response/user_response_model.dart';
import 'package:carimakan/service/connectivity/connectivity_service.dart';
import 'package:carimakan/service/connectivity/connectivity_status.dart';

import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:carimakan/utils/project_exception.dart';
import 'package:carimakan/utils/stream_key.dart';
import 'package:stacked/stacked.dart';

import 'package:carimakan/repository/food_repository.dart';
import 'package:carimakan/repository/user_repository.dart';

class HomeViewModel extends MultipleStreamViewModel {
  final _nav = locator<NavigationService>();
  final _connectivity = locator<ConnectivityService>();

  final _foodRepo = locator<FoodRepository>();
  final _userRepo = locator<UserRepository>();

  List<FoodModel> foods;
  UserModel user;
  String userToken;

  bool _isNoConnection = false;
  bool get isNoConnection => _isNoConnection;
  bool _isSomethingError = false;
  bool get isSomethingError => _isSomethingError;

  @override
  Map<String, StreamData> get streamsMap => {
        StreamKey.connectivity:
            StreamData<ConnectivityStatus>(_connectivity.status),
        StreamKey.authStatus: StreamData<bool>(_userRepo.isLogin),
        StreamKey.profileUpdated: StreamData<bool>(_userRepo.isProfileUpdated),
      };

  @override
  void onData(String key, data) {
    super.onData(key, data);
    if (key == StreamKey.authStatus) {
      if (!data && user != null) clearUser();
      if (data && user == null && !_isSomethingError && !_isNoConnection) {
        getUserData();
      }
    } else if (key == StreamKey.profileUpdated) {
      if (data) {
        _userRepo.setIsProfileUpdated(false);
        getUserData();
      }
    }
  }

  void _resetError() {
    _isNoConnection = false;
    _isSomethingError = false;
  }

  void _checkError() {
    if (dataMap[StreamKey.connectivity] == ConnectivityStatus.Offline) {
      _isNoConnection = true;
    } else {
      _isSomethingError = true;
    }
  }

  Future<void> firstLoad() async {
    _resetError();
    runBusyFuture(getFood());
  }

  void clearUser() {
    user = null;
    userToken = null;
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
      _checkError();
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
      _checkError();
      notifyListeners();
    }
  }

  void goToFoodDetail(FoodModel food) {
    _nav.pushNamed(
      Routes.foodDetailPage,
      arguments: FoodDetailPageArguments(food: food),
    );
  }
}
