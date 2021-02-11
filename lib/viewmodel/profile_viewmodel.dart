import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/model/response/user_response_model.dart';
import 'package:carimakan/repository/user_repository.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:carimakan/ui/components/atom/dialog.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/viewmodel/main_viewmodel.dart';

class ProfileViewModel extends StreamViewModel {
  final _nav = locator<NavigationService>();
  final _userRepo = locator<UserRepository>();
  final _mainVM = locator<MainViewModel>();

  UserModel user;
  String userToken;

  @override
  Stream get stream => _userRepo.isLogin;

  @override
  void onData(data) {
    super.onData(data);
    if (!data && user != null) clearUser();
    if (data && user == null) getUser();
  }

  void clearUser() {
    user = null;
    userToken = null;
    notifyListeners();
  }

  Future<void> firstLoad() async {}

  Future<void> getUser() async {
    try {
      if (userToken == null) await getUserToken();
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

  void showLogoutDialog(BuildContext context) async {
    var action = await Dialogs.yesNoDialog(
      context: context,
      isReverse: true,
      title: "Are you sure?",
    );
    if (action == DialogAction.yes) logout();
  }

  void logout() {
    _userRepo.logout();
    goToHome();
  }
}
