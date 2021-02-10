import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/model/response/user_response_model.dart';
import 'package:carimakan/repository/user_repository.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/viewmodel/main_viewmodel.dart';

class ProfileViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _userRepo = locator<UserRepository>();
  final _mainVM = locator<MainViewModel>();

  UserModel user;
  String userToken;

  Future<void> firstLoad() async {
    await runBusyFuture(getUserToken());
    runBusyFuture(getUser());
  }

  Future<void> getUser() async {
    try {
      user = _userRepo.getUserData();
      if (user == null) {
        if (userToken == null) {
          logout();
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

  void goToSignInPage() {
    _nav.pushNamed(Routes.signInPage);
  }

  void goToHome() => _mainVM.setIndex(0);

  void logout() {
    _userRepo.logout();
    goToHome();
  }
}
