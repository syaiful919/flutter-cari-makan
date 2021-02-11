import 'package:carimakan/ui/components/atom/illustration.dart';
import 'package:carimakan/ui/components/base/loading.dart';
import 'package:carimakan/utils/project_images.dart';
import 'package:carimakan/utils/shared_value.dart';
import 'package:carimakan/viewmodel/after_payment_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AfterPaymentPage extends StatelessWidget {
  final int orderId;
  const AfterPaymentPage({Key key, this.orderId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AfterPaymentViewModel>.reactive(
      onModelReady: (model) =>
          model.firstLoad(context: context, orderId: orderId),
      viewModelBuilder: () => AfterPaymentViewModel(),
      builder: (_, model, __) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: model.status == null
              ? Center(child: Loading())
              : Illustration(
                  title: model.status == TransactionStatus.pending
                      ? "We're Waiting for Your Payment"
                      : "You've Made Order",
                  subtitle: model.status == TransactionStatus.pending
                      ? "Please finish your payment, so we can prepare your best foods"
                      : "Just stay at home while we are\npreparing your best foods",
                  picturePath: model.status == TransactionStatus.pending
                      ? ProjectImages.foodWishes
                      : ProjectImages.bike,
                  buttonTap1: () => model.goToHome(),
                  buttonTitle1: 'Order Other Foods',
                  buttonTap2: () => model.goToOrderHistory(),
                  buttonTitle2: 'View My Order',
                ),
        ),
      ),
    );
  }
}
