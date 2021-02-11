import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/model/request/sign_up_request_model.dart';
import 'package:carimakan/model/response/auth_response_model.dart';
import 'package:carimakan/repository/transaction_repository.dart';
import 'package:carimakan/repository/user_repository.dart';
import 'package:carimakan/service/flushbar/flushbar_service.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:carimakan/utils/project_exception.dart';
import 'package:carimakan/viewmodel/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/extension/extended_string.dart';

class AddressViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _userRepo = locator<UserRepository>();
  final _transactionRepo = locator<TransactionRepository>();

  final _mainVM = locator<MainViewModel>();

  final _flush = locator<FlushbarService>();

  BuildContext _pageContext;
  String _userToken;
  UserModel _user;

  SignUpRequestModel _request;

  List<String> _cities;
  List<String> get cities => _cities;

  String _selectedCity;
  String get selectedCity => _selectedCity;

  bool _tryingToSignUp = false;
  bool get tryingToSignUp => _tryingToSignUp;

  Future<void> firstLoad({
    BuildContext context,
    SignUpRequestModel request,
  }) async {
    if (_pageContext == null && context != null) _pageContext = context;
    _request = request;
    getCities();
  }

  void getCities() {
    _cities = ['Bandung', 'Jakarta', 'Surabaya'];
    _selectedCity = _cities[0];
  }

  void changeCity(String val) {
    _selectedCity = val;
    notifyListeners();
  }

  void changePhone(String val) {
    _request.phoneNumber = val;
    notifyListeners();
  }

  void changeAddress(String val) {
    _request.address = val;
    notifyListeners();
  }

  void changeHouse(String val) {
    _request.houseNumber = val;
    notifyListeners();
  }

  Future<void> signUp() async {
    if (_request.phoneNumber.isNotSafety()) {
      _flush.showFlushbar(
        context: _pageContext,
        message: "Phone number can't be empty",
      );
    } else if (_request.address.isNotSafety()) {
      _flush.showFlushbar(
        context: _pageContext,
        message: "Address can't be empty",
      );
    } else if (_request.houseNumber.isNotSafety()) {
      _flush.showFlushbar(
        context: _pageContext,
        message: "House number can't be empty",
      );
    } else {
      signUpAction();
    }
  }

  Future<void> signUpAction() async {
    try {
      toggleTryingToSignUp();
      _request.city = _selectedCity;

      AuthResponseModel response = await _userRepo.signUp(request: _request);
      await afterSignUp(response);
    } on BadRequestException {
      _flush.showFlushbar(
          context: _pageContext, message: "The email has already been taken");
    } catch (e) {
      print(">>> sign in error $e");
      _flush.showFlushbar(context: _pageContext, message: "Sign Up failed");
    } finally {
      toggleTryingToSignUp();
    }
  }

  Future<void> afterSignUp(AuthResponseModel response) async {
    _userToken = response.data.accessToken;
    _user = response.data.user;

    if (_request.profilePicture != null) {
      String photoUrl = await uploadImage();
      if (photoUrl != null) _user.profilePhotoUrl = photoUrl;
    }

    _userRepo.saveUserToken(_userToken);
    _userRepo.saveUserData(_user);
    _userRepo.setIsLogin(true);
    _mainVM.setIndex(0);
    _transactionRepo.setIsNeedReloadTransaction(true);
    _nav.pushNamedAndRemoveUntil(Routes.mainPage);
    _nav.pushNamed(Routes.afterSignUpPage);
  }

  void toggleTryingToSignUp() {
    _tryingToSignUp = !_tryingToSignUp;
    notifyListeners();
  }

  void goBack() => _nav.pop();

  Future<String> uploadImage() async {
    try {
      String result = await _userRepo.uploadPhotoProfile(
        image: _request.profilePicture,
        token: _userToken,
      );
      return result;
    } catch (e) {
      print(">>> error $e");
      return null;
    }
  }
}
