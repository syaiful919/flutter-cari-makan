import 'package:carimakan/ui/components/atoms/illustration.dart';
import 'package:carimakan/utils/project_images.dart';
import 'package:carimakan/viewmodel/after_sign_up_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AfterSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AfterSignUpViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => AfterSignUpViewModel(),
      builder: (_, model, __) => Scaffold(
        body: Illustration(
          title: "Yeay! Completed",
          subtitle: "Now you are able to order\nsome foods as a self-reward",
          picturePath: ProjectImages.foodWishes,
          buttonTap1: () => model.goBack(),
          buttonTitle1: 'Find Foods',
        ),
      ),
    );
  }
}
