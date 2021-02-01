import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/food_model.dart';
import 'package:carimakan/model/response/food_response_model.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'package:carimakan/repository/food_repository.dart';

class HomeViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _foodRepo = locator<FoodRepository>();

  BuildContext pageContext;

  List<FoodModel> foods;

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
    runBusyFuture(getFood());
  }

  Future<void> getFood() async {
    try {
      FoodResponseModel result = await _foodRepo.getFood();
      if (result.data.foods.length > 0) {
        foods = result.data.foods;
      }
    } catch (e) {
      print(">>> get food error: $e");
    }
  }

  void goBack() => _nav.pop();
}
