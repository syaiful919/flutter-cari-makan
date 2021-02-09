import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddressViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();

  BuildContext pageContext;

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
  }

  void goBack() => _nav.pop();
}
