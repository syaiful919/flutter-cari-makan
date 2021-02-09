import 'package:carimakan/ui/components/base/base_button.dart';
import 'package:carimakan/ui/components/base/shrink_column.dart';
import 'package:carimakan/ui/components/template/general.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/viewmodel/sign_in_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/ui/components/base/base_input.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => SignInViewModel(),
      builder: (_, model, __) => General(
        title: 'Sign In',
        subtitle: "Find your best ever meal",
        onBackButtonPressed: () => model.goBack(),
        child: Padding(
          padding: const EdgeInsets.all(Gap.main),
          child: ShrinkColumn.start(
            children: <Widget>[
              BaseInput(
                controller: emailController,
                label: "Email Address",
                placeHolder: 'Type your email address',
                onChanged: (val) {},
              ),
              SizedBox(height: Gap.main),
              BaseInput(
                passwordType: true,
                controller: passwordController,
                label: "Password",
                placeHolder: 'Type your email password',
                onChanged: (val) {},
              ),
              SizedBox(height: Gap.l),
              BaseButton(
                title: "Sign In",
                onPressed: () {},
              ),
              SizedBox(height: Gap.s),
              BaseButton(
                title: "Create New Account",
                onPressed: () {},
                color: ProjectColor.grey2,
                titleColor: ProjectColor.white1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
