import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/service/connectivity/connectivity_service.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MidtransViewModel extends StreamViewModel {
  final _nav = locator<NavigationService>();
  final _connectivity = locator<ConnectivityService>();

  BuildContext pageContext;
  int orderId;
  String redirectUrl;

  @override
  Stream get stream => _connectivity.status;

  String injectedCss =
      ".header{     display: none !important;   }   .app-container{     padding-top: 0px !important;   }";

  Future<void> firstLoad({
    BuildContext context,
    int id,
    String url,
  }) async {
    if (pageContext == null && context != null) pageContext = context;
    orderId = id;
    redirectUrl = url;
    notifyListeners();
  }

  void goBack({dynamic params}) => _nav.pop(params: params);

  void goToAfterPaymentPage() async {
    _nav.pushNamedAndRemoveUntil(Routes.mainPage);
    _nav.pushNamed(
      Routes.afterPaymentPage,
      arguments: AfterPaymentPageArguments(orderId: orderId),
    );
  }
}
