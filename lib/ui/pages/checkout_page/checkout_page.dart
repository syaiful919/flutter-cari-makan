import 'package:carimakan/model/request/transaction_request_model.dart';
import 'package:carimakan/ui/components/template/general.dart';
import 'package:carimakan/viewmodel/checkout_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CheckoutPage extends StatelessWidget {
  final TransactionRequestModel transactionRequest;

  const CheckoutPage({Key key, this.transactionRequest}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckoutViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => CheckoutViewModel(),
      builder: (_, model, __) => General(
        title: 'Payment',
        subtitle: 'You deserve better meal',
      ),
    );
  }
}
