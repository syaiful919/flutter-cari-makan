import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/food_model.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FoodDetailViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();

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

  void goBack() => _nav.pop();
}
