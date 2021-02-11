// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:carimakan/ui/pages/main_page/main_page.dart';
import 'package:carimakan/ui/pages/food_detail_page/food_detail_page.dart';
import 'package:carimakan/model/entity/food_model.dart';
import 'package:carimakan/ui/pages/sign_in_page/sign_in_page.dart';
import 'package:carimakan/ui/pages/sign_up_page/sign_up_page.dart';
import 'package:carimakan/ui/pages/address_page/address_page.dart';
import 'package:carimakan/model/request/sign_up_request_model.dart';
import 'package:carimakan/ui/pages/checkout_page/checkout_page.dart';
import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/ui/pages/order_detail_page/order_detail_page.dart';
import 'package:carimakan/ui/pages/after_checkout_page/after_checkout_page.dart';
import 'package:carimakan/ui/pages/midtrans_page/midtrans_page.dart';
import 'package:carimakan/ui/pages/after_payment_page/after_payment_page.dart';
import 'package:carimakan/ui/pages/after_sign_up_page/after_sign_up_page.dart';

abstract class Routes {
  static const mainPage = '/';
  static const foodDetailPage = '/food-detail-page';
  static const signInPage = '/sign-in-page';
  static const signUpPage = '/sign-up-page';
  static const addressPage = '/address-page';
  static const checkoutPage = '/checkout-page';
  static const orderDetailPage = '/order-detail-page';
  static const afterCheckoutPage = '/after-checkout-page';
  static const midtransPage = '/midtrans-page';
  static const afterPaymentPage = '/after-payment-page';
  static const afterSignUpPage = '/after-sign-up-page';
  static const all = {
    mainPage,
    foodDetailPage,
    signInPage,
    signUpPage,
    addressPage,
    checkoutPage,
    orderDetailPage,
    afterCheckoutPage,
    midtransPage,
    afterPaymentPage,
    afterSignUpPage,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.mainPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => MainPage(),
          settings: settings,
        );
      case Routes.foodDetailPage:
        if (hasInvalidArgs<FoodDetailPageArguments>(args)) {
          return misTypedArgsRoute<FoodDetailPageArguments>(args);
        }
        final typedArgs =
            args as FoodDetailPageArguments ?? FoodDetailPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              FoodDetailPage(key: typedArgs.key, food: typedArgs.food),
          settings: settings,
        );
      case Routes.signInPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SignInPage(),
          settings: settings,
        );
      case Routes.signUpPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SignUpPage(),
          settings: settings,
        );
      case Routes.addressPage:
        if (hasInvalidArgs<AddressPageArguments>(args)) {
          return misTypedArgsRoute<AddressPageArguments>(args);
        }
        final typedArgs =
            args as AddressPageArguments ?? AddressPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => AddressPage(
              key: typedArgs.key, signUpRequest: typedArgs.signUpRequest),
          settings: settings,
        );
      case Routes.checkoutPage:
        if (hasInvalidArgs<CheckoutPageArguments>(args)) {
          return misTypedArgsRoute<CheckoutPageArguments>(args);
        }
        final typedArgs =
            args as CheckoutPageArguments ?? CheckoutPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => CheckoutPage(
              key: typedArgs.key, transaction: typedArgs.transaction),
          settings: settings,
        );
      case Routes.orderDetailPage:
        if (hasInvalidArgs<OrderDetailPageArguments>(args)) {
          return misTypedArgsRoute<OrderDetailPageArguments>(args);
        }
        final typedArgs =
            args as OrderDetailPageArguments ?? OrderDetailPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => OrderDetailPage(
              key: typedArgs.key, transaction: typedArgs.transaction),
          settings: settings,
        );
      case Routes.afterCheckoutPage:
        if (hasInvalidArgs<AfterCheckoutPageArguments>(args)) {
          return misTypedArgsRoute<AfterCheckoutPageArguments>(args);
        }
        final typedArgs =
            args as AfterCheckoutPageArguments ?? AfterCheckoutPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => AfterCheckoutPage(
              key: typedArgs.key,
              paymentUrl: typedArgs.paymentUrl,
              transactionId: typedArgs.transactionId),
          settings: settings,
        );
      case Routes.midtransPage:
        if (hasInvalidArgs<MidtransPageArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<MidtransPageArguments>(args);
        }
        final typedArgs = args as MidtransPageArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => MidtransPage(
              redirectUrl: typedArgs.redirectUrl, orderId: typedArgs.orderId),
          settings: settings,
        );
      case Routes.afterPaymentPage:
        if (hasInvalidArgs<AfterPaymentPageArguments>(args)) {
          return misTypedArgsRoute<AfterPaymentPageArguments>(args);
        }
        final typedArgs =
            args as AfterPaymentPageArguments ?? AfterPaymentPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              AfterPaymentPage(key: typedArgs.key, orderId: typedArgs.orderId),
          settings: settings,
        );
      case Routes.afterSignUpPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => AfterSignUpPage(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//FoodDetailPage arguments holder class
class FoodDetailPageArguments {
  final Key key;
  final FoodModel food;
  FoodDetailPageArguments({this.key, this.food});
}

//AddressPage arguments holder class
class AddressPageArguments {
  final Key key;
  final SignUpRequestModel signUpRequest;
  AddressPageArguments({this.key, this.signUpRequest});
}

//CheckoutPage arguments holder class
class CheckoutPageArguments {
  final Key key;
  final TransactionModel transaction;
  CheckoutPageArguments({this.key, this.transaction});
}

//OrderDetailPage arguments holder class
class OrderDetailPageArguments {
  final Key key;
  final TransactionModel transaction;
  OrderDetailPageArguments({this.key, this.transaction});
}

//AfterCheckoutPage arguments holder class
class AfterCheckoutPageArguments {
  final Key key;
  final String paymentUrl;
  final int transactionId;
  AfterCheckoutPageArguments({this.key, this.paymentUrl, this.transactionId});
}

//MidtransPage arguments holder class
class MidtransPageArguments {
  final String redirectUrl;
  final int orderId;
  MidtransPageArguments({@required this.redirectUrl, this.orderId});
}

//AfterPaymentPage arguments holder class
class AfterPaymentPageArguments {
  final Key key;
  final int orderId;
  AfterPaymentPageArguments({this.key, this.orderId});
}
