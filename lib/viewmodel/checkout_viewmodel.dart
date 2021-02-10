import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/model/response/user_response_model.dart';
import 'package:carimakan/repository/transaction_repository.dart';
import 'package:carimakan/repository/user_repository.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:carimakan/viewmodel/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CheckoutViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _userRepo = locator<UserRepository>();
  final _transactionRepo = locator<TransactionRepository>();
  final _mainVM = locator<MainViewModel>();

  BuildContext _pageContext;
  String _userToken;

  UserModel _user;
  UserModel get user => _user;

  TransactionModel _transaction;
  TransactionModel get transaction => _transaction;

  int _driverPrice;
  int get driverPrice => _driverPrice;
  int _taxPrice;
  int get taxPrice => _taxPrice;

  Future<void> firstLoad({
    BuildContext context,
    TransactionModel transaction,
  }) async {
    if (_pageContext == null && context != null) _pageContext = context;
    _transaction = transaction;
    calculateOrder();
    notifyListeners();
    await runBusyFuture(getUserToken());
    runBusyFuture(getUser());
  }

  Future<void> getUserToken() async {
    try {
      _userToken = _userRepo.getUserToken();
    } catch (e) {
      print(">>> get user token error $e");
    }
  }

  void calculateOrder() {
    _driverPrice = 10000;
    _taxPrice = ((transaction.quantity * transaction.food.price) * 0.1).floor();
    _transaction.total = (transaction.quantity * transaction.food.price) +
        _driverPrice +
        _taxPrice;
  }

  Future<void> getUser() async {
    try {
      _user = _userRepo.getUserData();
      if (user == null) {
        if (_userToken == null) {
          logout();
        } else {
          UserResponseModel response =
              await _userRepo.getUserDataRemote(token: _userToken);
          if (response.data != null) {
            _user = response.data;
            _userRepo.saveUserData(response.data);
          }
        }
      }
    } catch (e) {
      print(">>> get user data error $e");
    }
  }

  void goBack() => _nav.pop();

  void logout() {
    _userRepo.logout();
    goToHome();
  }

  void goToHome() {
    _mainVM.setIndex(0);
    _nav.pushNamedAndRemoveUntil(Routes.mainPage);
  }
}
