import 'package:carimakan/ui/components/atoms/image_picker_dialog.dart';
import 'package:carimakan/ui/components/bases/base_button.dart';
import 'package:carimakan/ui/components/bases/base_input.dart';
import 'package:carimakan/ui/components/bases/shrink_column.dart';
import 'package:carimakan/ui/components/templates/general.dart';
import 'package:carimakan/utils/project_images.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/viewmodel/edit_profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => EditProfileViewModel(),
      builder: (_, model, __) => General(
        title: 'Edit Profile',
        subtitle: "Update your profile",
        onBackButtonPressed: () => model.goBack(),
        child: model.user == null ? Container() : BodySection(),
      ),
    );
  }
}

class BodySection extends HookViewModelWidget<EditProfileViewModel> {
  @override
  Widget buildViewModelWidget(context, model) {
    var nameController = useTextEditingController(text: model.user.name);
    var emailController = useTextEditingController(text: model.user.email);

    return Padding(
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
                              image: NetworkImage(model.user.profilePhotoUrl),
                              fit: BoxFit.cover)),
                    ),
            ),
          ),
          BaseInput(
            controller: emailController,
            label: "Email Address",
            placeHolder: 'Type your email address',
            onChanged: (val) {},
            keyboardType: TextInputType.emailAddress,
            disabled: true,
          ),
          SizedBox(height: Gap.main),
          BaseInput(
            controller: nameController,
            label: "Full Name",
            placeHolder: 'Type your full name',
            onChanged: (val) => model.changeName(val),
          ),
          SizedBox(height: Gap.l),
          BaseButton(
            title: "Update Profile",
            onPressed: () => model.updateProfile(),
            loading: model.tryingToUpdateProfile,
          ),
          SizedBox(height: Gap.main),
        ],
      ),
    );
  }
}
