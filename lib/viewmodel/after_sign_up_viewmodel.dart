import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AfterSignUpViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();

  BuildContext _pageContext;

  Future<void> firstLoad({
    BuildContext context,
    String url,
    int transactionId,
  }) async {
    if (_pageContext == null && context != null) _pageContext = context;
  }

  void goBack() => _nav.pop();
}
