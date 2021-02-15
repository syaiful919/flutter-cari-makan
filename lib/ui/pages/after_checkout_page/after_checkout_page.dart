import 'package:carimakan/ui/components/atoms/illustration.dart';
import 'package:carimakan/utils/project_images.dart';
import 'package:carimakan/viewmodel/after_checkout_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AfterCheckoutPage extends StatelessWidget {
  final String paymentUrl;
  final int transactionId;
  const AfterCheckoutPage({Key key, this.paymentUrl, this.transactionId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AfterCheckoutViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(
        context: context,
        url: paymentUrl,
        transactionId: transactionId,
      ),
      viewModelBuilder: () => AfterCheckoutViewModel(),
      builder: (_, model, __) => Scaffold(
        body: Illustration(
          title: "Finish Your Payment",
          subtitle: "Please select your favourite\npayment method",
          picturePath: ProjectImages.payment,
          buttonTap1: () => model.pay(),
          buttonTitle1: 'Pay Now',
          buttonTap2: () => model.goBack(),
          buttonTitle2: 'Pay later',
        ),
      ),
    );
  }
}
