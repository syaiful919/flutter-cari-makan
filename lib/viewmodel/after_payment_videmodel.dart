import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/utils/shared_value.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AfterPaymentViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();

  BuildContext _pageContext;

  int _orderId;
  TransactionStatus _status;
  TransactionStatus get status => _status;

  Future<void> firstLoad({BuildContext context, int orderId}) async {
    if (_pageContext == null && context != null) _pageContext = context;
    _orderId = orderId;
    checkStatus();
  }

  void goBack() => _nav.pop();

  void checkStatus() {}
}
