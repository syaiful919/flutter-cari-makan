import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/model/request/update_user_request_model.dart';
import 'package:carimakan/model/response/user_response_model.dart';
import 'package:carimakan/repository/user_repository.dart';
import 'package:carimakan/service/flushbar/flushbar_service.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:carimakan/viewmodel/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/extension/extended_string.dart';

class EditAddressViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _userRepo = locator<UserRepository>();

  final _mainVM = locator<MainViewModel>();

  final _flush = locator<FlushbarService>();

  BuildContext _pageContext;
  String _userToken;
  UserModel _user;
  UserModel get user => _user;

  List<String> _cities;
  List<String> get cities => _cities;

  bool _tryingToUpdateAddress = false;
  bool get tryingToUpdateAddress => _tryingToUpdateAddress;

  Future<void> firstLoad({
    BuildContext context,
  }) async {
    if (_pageContext == null && context != null) _pageContext = context;
    await runBusyFuture(getUserToken());
    await runBusyFuture(getUser());
    getCities();
  }

  Future<void> getUserToken() async {
    try {
      _userToken = _userRepo.getUserToken();
    } catch (e) {
      print(">>> get user token error $e");
    }
  }

  Future<void> getUser() async {
    try {
      _user = _userRepo.getUserData();
      if (_user == null) {
        UserResponseModel response =
            await _userRepo.getUserDataRemote(token: _userToken);
        if (response.data != null) {
          _user = response.data;
          _userRepo.saveUserData(response.data);
        }
      }
    } catch (e) {
      print(">>> get user data error $e");
    }
  }

  void getCities() {
    _cities = ['Bandung', 'Jakarta', 'Surabaya'];
  }

  void changeCity(String val) {
    _user.city = val;
    notifyListeners();
  }

  void changePhone(String val) {
    _user.phoneNumber = val;
    notifyListeners();
  }

  void changeAddress(String val) {
    _user.address = val;
    notifyListeners();
  }

  void changeHouse(String val) {
    _user.houseNumber = val;
    notifyListeners();
  }

  Future<void> updateAddress() async {
    if (_user.phoneNumber.isNotSafety()) {
      _flush.showFlushbar(
        context: _pageContext,
        message: "Phone number can't be empty",
      );
    } else if (_user.address.isNotSafety()) {
      _flush.showFlushbar(
        context: _pageContext,
        message: "Address can't be empty",
      );
    } else if (_user.houseNumber.isNotSafety()) {
      _flush.showFlushbar(
        context: _pageContext,
        message: "House number can't be empty",
      );
    } else {
      updateAddressAction();
    }
  }

  Future<void> updateAddressAction() async {
    try {
      toggleTryingToUpdateAddress();
      UpdateUserRequestModel request = UpdateUserRequestModel(
        address: _user.address,
        houseNumber: _user.houseNumber,
        phoneNumber: _user.phoneNumber,
        city: _user.city,
      );

      UserResponseModel response =
          await _userRepo.updateUser(request: request, token: _userToken);
      await afterSignUp(response);
    } catch (e) {
      print(">>> update address error $e");
      _flush.showFlushbar(
          context: _pageContext, message: "Update address failed");
    } finally {
      toggleTryingToUpdateAddress();
    }
  }

  Future<void> afterSignUp(UserResponseModel response) async {
    _user = response.data;

    _userRepo.saveUserData(_user);
    _mainVM.setIndex(0);
    _nav.pushNamedAndRemoveUntil(Routes.mainPage);
  }

  void toggleTryingToUpdateAddress() {
    _tryingToUpdateAddress = !_tryingToUpdateAddress;
    notifyListeners();
  }

  void goBack() => _nav.pop();
}
