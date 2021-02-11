import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/utils/shared_value.dart';
import 'package:carimakan/viewmodel/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/repository/transaction_repository.dart';

import 'package:carimakan/model/response/transaction_response_model.dart';
import 'package:carimakan/repository/user_repository.dart';

class AfterPaymentViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _transactionRepo = locator<TransactionRepository>();
  final _userRepo = locator<UserRepository>();
  final _mainVM = locator<MainViewModel>();

  BuildContext _pageContext;

  String _userToken;

  int _orderId;
  TransactionStatus _status;
  TransactionStatus get status => _status;

  Future<void> firstLoad({BuildContext context, int orderId}) async {
    if (_pageContext == null && context != null) _pageContext = context;
    _orderId = orderId;
    await getUserToken();
    runBusyFuture(checkStatus());
  }

  void goBack() => _nav.pop();

  Future<void> checkStatus() async {
    try {
      TransactionResponseModel response = await _transactionRepo
          .getTransactionById(id: _orderId, token: _userToken);
      if (response.data != null) {
        _status = response.data.getStatus();
      }
    } catch (e) {
      print(">>> get transaction error");
    }
  }

  Future<void> getUserToken() async {
    try {
      _userToken = _userRepo.getUserToken();
    } catch (e) {
      print(">>> get user token error $e");
    }
  }

  void goToHome() {
    triggerTransactionToReload();
    _mainVM.setIndex(0);
    goBack();
  }

  void goToOrderHistory() {
    triggerTransactionToReload();
    _mainVM.setIndex(1);
    goBack();
  }

  void triggerTransactionToReload() {
    _transactionRepo.setIsNeedReloadTransaction(true);
  }
}
