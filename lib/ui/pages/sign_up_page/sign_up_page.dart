import 'package:carimakan/ui/components/template/general.dart';
import 'package:carimakan/viewmodel/sign_up_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => SignUpViewModel(),
      builder: (_, model, __) => General(
        title: 'Sign Up',
        subtitle: "Register and eat",
      ),
    );
  }
}
