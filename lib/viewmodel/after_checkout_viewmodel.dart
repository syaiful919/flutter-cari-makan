import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AfterCheckoutViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();

  BuildContext _pageContext;

  String _url;
  String get url => _url;

  int _transactionId;

  Future<void> firstLoad({
    BuildContext context,
    String url,
    int transactionId,
  }) async {
    if (_pageContext == null && context != null) _pageContext = context;
    _url = url;
    _transactionId = transactionId;
    notifyListeners();
  }

  void pay() {
    _nav.pushReplacementNamed(
      Routes.midtransPage,
      arguments: MidtransPageArguments(
          orderId: _transactionId, redirectUrl: _url + "#/bank-transfer"),
    );
  }

  void goBack() => _nav.pop();
}
