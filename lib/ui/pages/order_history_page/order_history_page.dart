import 'package:carimakan/viewmodel/order_history_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderHistoryViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(),
      viewModelBuilder: () => OrderHistoryViewModel(),
      builder: (_, model, __) => Scaffold(
        body: Center(
          child: Text(
            "Order History Page",
          ),
        ),
      ),
    );
  }
}
