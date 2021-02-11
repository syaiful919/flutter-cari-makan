import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/model/response/transaction_response_model.dart';
import 'package:carimakan/repository/user_repository.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/repository/transaction_repository.dart';

class OrderDetailViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _transactionRepo = locator<TransactionRepository>();
  final _userRepo = locator<UserRepository>();

  BuildContext _pageContext;

  String _userToken;

  TransactionModel _transaction;
  TransactionModel get transaction => _transaction;

  int _driverPrice;
  int get driverPrice => _driverPrice;
  int _taxPrice;
  int get taxPrice => _taxPrice;

  bool _tryingToReload = false;
  bool get tryingToReload => _tryingToReload;

  void toggleTryingToReload() {
    _tryingToReload = !_tryingToReload;
    notifyListeners();
  }

  Future<void> firstLoad({
    BuildContext context,
    TransactionModel transaction,
  }) async {
    if (_pageContext == null && context != null) _pageContext = context;
    _transaction = transaction;
    calculateAdditionalPrice();
    notifyListeners();
    runBusyFuture(getUserToken());
  }

  void calculateAdditionalPrice() {
    _driverPrice = 10000;
    _taxPrice = ((transaction.quantity * transaction.food.price) * 0.1).floor();
  }

  void pay() async {
    var result = await _nav.pushNamed(
      Routes.midtransPage,
      arguments: MidtransPageArguments(
          orderId: _transaction.id,
          redirectUrl: _transaction.paymentUrl + "#/bank-transfer"),
    );
    if (result != null && result) reload();
  }

  Future<void> reload() async {
    try {
      toggleTryingToReload();
      TransactionResponseModel response = await _transactionRepo
          .getTransactionById(id: _transaction.id, token: _userToken);
      if (response.data != null) {
        if (response.data.status != _transaction.status) {
          triggerTransactionToReload();
        }
        _transaction = response.data;
      }
    } catch (e) {
      print(">>> get transaction error");
    } finally {
      toggleTryingToReload();
    }
  }

  void triggerTransactionToReload() {
    _transactionRepo.setIsNeedReloadTransaction(true);
  }

  Future<void> getUserToken() async {
    try {
      _userToken = _userRepo.getUserToken();
    } catch (e) {
      print(">>> get user token error $e");
    }
  }

  void goBack() => _nav.pop();
}
