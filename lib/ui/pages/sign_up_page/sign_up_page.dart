import 'package:carimakan/ui/components/atom/image_picker_dialog.dart';
import 'package:carimakan/ui/components/base/base_button.dart';
import 'package:carimakan/ui/components/base/base_input.dart';
import 'package:carimakan/ui/components/base/shrink_column.dart';
import 'package:carimakan/ui/components/template/general.dart';
import 'package:carimakan/utils/project_images.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/viewmodel/sign_up_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController;
  TextEditingController nameController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => SignUpViewModel(),
      builder: (_, model, __) => General(
        title: 'Sign Up',
        subtitle: "Register and eat",
        onBackButtonPressed: () => model.goBack(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Gap.main),
          child: ShrinkColumn(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    useRootNavigator: false,
                    builder: (context) => ImagePickerDialog(
                      openCamera: () => model.openCamera(),
                      openGallery: () => model.openGallery(),
                    ),
                  );
                },
                child: Container(
                  width: 110,
                  height: 110,
                  margin: EdgeInsets.only(top: Gap.main, bottom: Gap.s),
                  padding: EdgeInsets.all(Gap.s),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ProjectImages.photoBorder))),
                  child: (model.image != null)
                      ? Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: FileImage(model.image),
                                  fit: BoxFit.cover)),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(ProjectImages.photo),
                                  fit: BoxFit.cover)),
                        ),
                ),
              ),
              BaseInput(
                controller: nameController,
                label: "Full Name",
                placeHolder: 'Type your full name',
                onChanged: (val) => model.changeName(val),
              ),
              SizedBox(height: Gap.main),
              BaseInput(
                controller: emailController,
                label: "Email Address",
                placeHolder: 'Type your email address',
                onChanged: (val) => model.changeEmail(val),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: Gap.main),
              BaseInput(
                passwordType: true,
                controller: passwordController,
                label: "Password",
                placeHolder: 'Type your email password',
                onChanged: (val) => model.changePassword(val),
              ),
              SizedBox(height: Gap.l),
              BaseButton(
                title: "Continue",
                onPressed: () => model.continueToAddressPage(),
              ),
              SizedBox(height: Gap.l),
            ],
          ),
        ),
      ),
    );
  }
}
