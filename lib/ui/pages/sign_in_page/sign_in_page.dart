import 'package:carimakan/ui/components/template/general.dart';
import 'package:carimakan/viewmodel/sign_in_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => SignInViewModel(),
      builder: (_, model, __) => General(
        title: 'Sign In',
        subtitle: "Find your best ever meal",
      ),
    );
  }
}
