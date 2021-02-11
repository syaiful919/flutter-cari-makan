import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class OrderDetailViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();

  BuildContext _pageContext;

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
    calculateAdditionalPrice();
    notifyListeners();
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
    if (result != null && result) {
      // reload
    }
  }

  void goBack() => _nav.pop();
}
