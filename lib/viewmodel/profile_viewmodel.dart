import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/model/response/user_response_model.dart';
import 'package:carimakan/repository/user_repository.dart';
import 'package:carimakan/service/connectivity/connectivity_service.dart';
import 'package:carimakan/service/connectivity/connectivity_status.dart';
import 'package:carimakan/service/flushbar/flushbar_service.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:carimakan/ui/components/atoms/dialog.dart';
import 'package:carimakan/utils/stream_key.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/viewmodel/main_viewmodel.dart';
import 'package:carimakan/dictionary/message_dictionary.dart';

class ProfileViewModel extends MultipleStreamViewModel {
  final _nav = locator<NavigationService>();
  final _connectivity = locator<ConnectivityService>();
  final _flush = locator<FlushbarService>();
  final _userRepo = locator<UserRepository>();
  final _mainVM = locator<MainViewModel>();

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
      };

  @override
  void onData(String key, data) {
    super.onData(key, data);
    if (key == StreamKey.authStatus) {
      if (!data && user != null) clearUser();
      if (data && user == null && !_isSomethingError && !_isNoConnection) {
        getUser();
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

  void clearUser() {
    user = null;
    userToken = null;
    notifyListeners();
  }

  Future<void> firstLoad() async {}

  Future<void> getUser() async {
    try {
      _resetError();
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
      _checkError();
    } finally {
      notifyListeners();
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

  void goToAddressPage() {
    _nav.pushNamed(Routes.editAddressPage);
  }

  void goToEditProfilePage() async {
    var result = await _nav.pushNamed(Routes.editProfilePage);
    if (result != null && result is UserModel) {
      user = result;
      notifyListeners();
    }
  }

  void showUnderDevelopmentMessage(BuildContext context) {
    _flush.showFlushbar(
      context: context,
      message: MessageDictionary.featureUnderDevelopment,
    );
  }

  void showNotPublishedMessage(BuildContext context) {
    _flush.showFlushbar(
      context: context,
      message: MessageDictionary.notYetPublished,
    );
  }
}
