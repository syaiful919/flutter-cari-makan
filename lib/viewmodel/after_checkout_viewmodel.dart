import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AfterCheckoutViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();

  BuildContext _pageContext;

  String _url;
  String get url => _url;

  Future<void> firstLoad({BuildContext context, String url}) async {
    if (_pageContext == null && context != null) _pageContext = context;
    _url = url;
    notifyListeners();
  }

  void pay() {
    //
    print(_url);
  }

  void goBack() => _nav.pop();
}
