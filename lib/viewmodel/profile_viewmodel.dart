import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/model/response/user_response_model.dart';
import 'package:carimakan/repository/user_repository.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _userRepo = locator<UserRepository>();

  UserModel user;
  String userToken;

  Future<void> firstLoad() async {
    runBusyFuture(getUser());
  }

  Future<void> getUser() async {
    try {
      user = _userRepo.getUserData();
      if (user == null) {
        await getUserToken();
        if (userToken == null) {
          // push to login page
        } else {
          UserResponseModel response =
              await _userRepo.getUserDataRemote(token: userToken);
          if (response.data != null) {
            user = response.data;
            _userRepo.saveUserData(response.data);
          }
        }
      }
    } catch (e) {
      print(">>> get user data error $e");
    }
  }

  Future<void> getUserToken() async {
    try {
      userToken = _userRepo.getUserToken();
    } catch (e) {
      print(">>> get user token error $e");
    }
  }

  void goBack() => _nav.pop();
}
