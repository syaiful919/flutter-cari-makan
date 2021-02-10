import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/food_model.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/repository/user_repository.dart';

class FoodDetailViewModel extends StreamViewModel {
  final _nav = locator<NavigationService>();
  final _userRepo = locator<UserRepository>();

  @override
  Stream get stream => _userRepo.isLogin;

  BuildContext _pageContext;

  FoodModel _food;
  FoodModel get food => _food;

  int _quantity = 1;
  int get quantity => _quantity;

  Future<void> firstLoad({BuildContext context, FoodModel food}) async {
    if (_pageContext == null && context != null) _pageContext = context;
    _food = food;
    notifyListeners();
  }

  void decreaseQuantity() {
    _quantity--;
    notifyListeners();
  }

  void increaseQuantity() {
    _quantity++;
    notifyListeners();
  }

  void goToCheckoutPage() {
    if (data) {
      _nav.pushNamed(
        Routes.checkoutPage,
        arguments: CheckoutPageArguments(
          transaction: TransactionModel(
            foodId: _food.id,
            food: _food,
            quantity: _quantity,
          ),
        ),
      );
    } else {
      _nav.pushNamed(Routes.signInPage);
    }
  }

  void goBack() => _nav.pop();
}
