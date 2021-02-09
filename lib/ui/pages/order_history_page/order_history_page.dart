import 'package:carimakan/utils/project_images.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/viewmodel/order_history_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/ui/components/atom/illustration.dart';

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderHistoryViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(),
      viewModelBuilder: () => OrderHistoryViewModel(),
      builder: (_, model, __) => Scaffold(
        backgroundColor: ProjectColor.white1,
        body: Illustration(
          title: 'Ouch! Hungry',
          subtitle: 'Seems you like have not\nordered any food yet',
          picturePath: ProjectImages.loveBurger,
          buttonTap1: () {},
          buttonTitle1: 'Find Foods',
        ),
      ),
    );
  }
}
