import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CheckoutViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();

  BuildContext _pageContext;

  TransactionModel _transaction;

  Future<void> firstLoad({
    BuildContext context,
    TransactionModel transaction,
  }) async {
    if (_pageContext == null && context != null) _pageContext = context;
    _transaction = transaction;
    notifyListeners();
  }

  void goBack() => _nav.pop();
}
