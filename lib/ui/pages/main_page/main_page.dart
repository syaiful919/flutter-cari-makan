import 'package:animations/animations.dart';
import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/ui/components/base/non_scallable_container.dart';
import 'package:carimakan/ui/pages/home_page/home_page.dart';
import 'package:carimakan/ui/pages/main_page/local_components/bottom_navigation_icon.dart';
import 'package:carimakan/ui/pages/order_history_page/order_history_page.dart';
import 'package:carimakan/ui/pages/profile_page/profile_page.dart';
import 'package:carimakan/utils/project_icons.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/viewmodel/main_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Tekan sekali lagi untuk keluar",
        backgroundColor: ProjectColor.black2,
        textColor: ProjectColor.white1,
        fontSize: TypoSize.secondary,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) =>
      ViewModelBuilder<MainViewModel>.reactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        fireOnModelReadyOnce: true,
        viewModelBuilder: () => locator<MainViewModel>(),
        onModelReady: (model) => model.firstLoad(),
        builder: (_, model, __) => WillPopScope(
          onWillPop: () async {
            DateTime now = DateTime.now();
            if (currentBackPressTime == null ||
                now.difference(currentBackPressTime) > Duration(seconds: 2)) {
              currentBackPressTime = now;
              Fluttertoast.showToast(
                msg: "Tekan sekali lagi untuk keluar",
                backgroundColor: ProjectColor.black2,
                textColor: ProjectColor.white1,
                fontSize: TypoSize.secondary,
              );
              return false;
            }
            return true;
          },
          child: Stack(
            children: <Widget>[
              Scaffold(
                body: PageTransitionSwitcher(
                  duration: const Duration(milliseconds: 200),
                  reverse: model.reverse,
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                  ) {
                    return SharedAxisTransition(
                      child: child,
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.horizontal,
                    );
                  },
                  child: getViewForIndex(model.currentIndex),
                ),
                bottomNavigationBar: NonScallableContainer(
                  child: BottomNavigationBar(
                    onTap: model.setPageIndex,
                    currentIndex: model.currentIndex,
                    backgroundColor: ProjectColor.white1,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    items: [
                      BottomNavigationBarItem(
                        icon: BottomNavigationIcon(ProjectIcons.homeDisabled),
                        activeIcon: BottomNavigationIcon(ProjectIcons.home),
                        title: Text("Home"),
                      ),
                      BottomNavigationBarItem(
                        icon: BottomNavigationIcon(ProjectIcons.orderDisabled),
                        activeIcon: BottomNavigationIcon(ProjectIcons.order),
                        title: Text("Order"),
                      ),
                      BottomNavigationBarItem(
                        icon:
                            BottomNavigationIcon(ProjectIcons.profileDisabled),
                        activeIcon: BottomNavigationIcon(ProjectIcons.profile),
                        title: Text("Profile"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return HomePage();
    case 1:
      return OrderHistoryPage();
    case 2:
      return ProfilePage();
    default:
      return HomePage();
  }
}
