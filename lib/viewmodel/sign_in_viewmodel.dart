import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/request/sign_in_request_model.dart';
import 'package:carimakan/repository/user_repository.dart';
import 'package:carimakan/service/flushbar/flushbar_service.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:carimakan/viewmodel/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/model/response/sign_in_response_model.dart';
import 'package:carimakan/repository/transaction_repository.dart';

class SignInViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _userRepo = locator<UserRepository>();
  final _transactionRepo = locator<TransactionRepository>();

  final _mainVM = locator<MainViewModel>();
  final _flush = locator<FlushbarService>();

  BuildContext _pageContext;

  String _email = "";
  String _password = "";

  bool _tryingToSignIn = false;
  bool get tryingToSignIn => _tryingToSignIn;

  Future<void> firstLoad({BuildContext context}) async {
    if (_pageContext == null && context != null) _pageContext = context;
  }

  void changeEmail(String val) {
    _email = val;
    notifyListeners();
  }

  void changePassword(String val) {
    _password = val;
    notifyListeners();
  }

  void toggleTryingToSignIn() {
    _tryingToSignIn = !_tryingToSignIn;
    notifyListeners();
  }

  Future<void> signIn() async {
    try {
      toggleTryingToSignIn();
      SignInResponseModel response = await _userRepo.signIn(
        request: SignInRequestModel(email: _email, password: _password),
      );
      afterSignIn(response);
    } catch (e) {
      print(">>> sign in error $e");
      _flush.showFlushbar(context: _pageContext, message: "Sign in failed");
    } finally {
      toggleTryingToSignIn();
    }
  }

  void afterSignIn(SignInResponseModel response) {
    _userRepo.saveUserToken(response.data.accessToken);
    _userRepo.saveUserData(response.data.user);
    _userRepo.setIsLogin(true);
    _mainVM.setIndex(0);
    _transactionRepo.setIsNeedReloadTransaction(true);
    _nav.pushNamedAndRemoveUntil(Routes.mainPage);
  }

  void goBack() => _nav.pop();
}
