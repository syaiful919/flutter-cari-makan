import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/ui/components/template/general.dart';
import 'package:carimakan/viewmodel/checkout_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CheckoutPage extends StatelessWidget {
  final TransactionModel transaction;

  const CheckoutPage({Key key, this.transaction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckoutViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(
        context: context,
        transaction: transaction,
      ),
      viewModelBuilder: () => CheckoutViewModel(),
      builder: (_, model, __) => General(
        title: 'Payment',
        subtitle: 'You deserve better meal',
      ),
    );
  }
}
