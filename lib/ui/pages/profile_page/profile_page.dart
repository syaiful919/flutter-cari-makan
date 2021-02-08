import 'package:carimakan/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(),
      viewModelBuilder: () => ProfileViewModel(),
      builder: (_, model, __) => Scaffold(
        body: Center(
          child: Text(
            "Profile Page",
          ),
        ),
      ),
    );
  }
}
