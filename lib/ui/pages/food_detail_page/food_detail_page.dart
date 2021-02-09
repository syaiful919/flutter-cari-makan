import 'package:carimakan/model/entity/food_model.dart';
import 'package:carimakan/viewmodel/food_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class FoodDetailPage extends StatelessWidget {
  final FoodModel food;

  const FoodDetailPage({Key key, this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FoodDetailViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => FoodDetailViewModel(),
      builder: (_, model, __) => Center(
        child: Text("Food Detail Page"),
      ),
    );
  }
}
