import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/ui/components/atom/custom_tabbar.dart';
import 'package:carimakan/ui/components/base/loading.dart';
import 'package:carimakan/utils/project_images.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: true,
      onModelReady: (model) => model.firstLoad(),
      viewModelBuilder: () => locator<ProfileViewModel>(),
      builder: (_, model, __) => Scaffold(
        body: model.user == null
            ? Center(child: Loading())
            : ListView(
                children: <Widget>[
                  HeaderSection(),
                  BodySection(),
                ],
              ),
      ),
    );
  }
}

class BodySection extends HookViewModelWidget<ProfileViewModel> {
  @override
  Widget buildViewModelWidget(context, model) {
    var selectedIndex = useState(0);

    return Container(
      width: double.infinity,
      color: ProjectColor.white1,
      child: Column(
        children: <Widget>[
          CustomTabBar(
            titles: ["Account", "App"],
            selectedIndex: selectedIndex.value,
            onTap: (index) {
              selectedIndex.value = index;
            },
          ),
          SizedBox(height: Gap.m),
          selectedIndex.value == 0 ? AccountTabSection() : AppTabSection()
        ],
      ),
    );
  }
}

class AccountTabSection extends ViewModelWidget<ProfileViewModel> {
  AccountTabSection() : super(reactive: false);
  @override
  Widget build(context, model) {
    return Column(
      children: <Widget>[
        ProfileItem(
          title: 'Edit Profile',
          onTap: () {},
        ),
        ProfileItem(
          title: "Home Address",
          onTap: () {},
        ),
      ],
    );
  }
}

class AppTabSection extends ViewModelWidget<ProfileViewModel> {
  AppTabSection() : super(reactive: false);
  @override
  Widget build(context, model) {
    return Column(
      children: <Widget>[
        ProfileItem(
          title: "Rate App",
          onTap: () {},
        ),
        ProfileItem(
          title: "Help Center",
          onTap: () {},
        ),
        ProfileItem(
          title: "Privacy & Policy",
          onTap: () {},
        ),
        ProfileItem(
          title: "Term & Condition",
          onTap: () {},
        ),
      ],
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ProfileItem({Key key, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: Gap.m, left: Gap.main, right: Gap.main),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TypoStyle.mainBlack),
            Icon(Icons.arrow_forward_ios, color: ProjectColor.grey2),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends ViewModelWidget<ProfileViewModel> {
  @override
  Widget build(context, model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Gap.main),
      height: 220,
      margin: EdgeInsets.only(bottom: Gap.main),
      width: double.infinity,
      color: ProjectColor.white1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            margin: EdgeInsets.only(bottom: Gap.m),
            padding: EdgeInsets.all(Gap.s),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ProjectImages.photoBorder),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(model.user.profilePhotoUrl),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Text(model.user.name, style: TypoStyle.header3Black500),
          Text(model.user.email, style: TypoStyle.mainGrey300)
        ],
      ),
    );
  }
}
