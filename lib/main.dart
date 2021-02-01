import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:carimakan/utils/config.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: ProjectConfig.projectName,
        theme: projectTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Router().onGenerateRoute,
        initialRoute: Routes.mainPage,
        navigatorKey: locator<NavigationService>().navigationKey,
        builder: (context, widget) => Navigator(
          onGenerateRoute: (settings) {
            final mediaQueryData = MediaQuery.of(context);
            final constrainedTextScaleFactor =
                mediaQueryData.textScaleFactor.clamp(1.0, 1.1);

            return MaterialPageRoute(
              builder: (context) => MediaQuery(
                data: mediaQueryData.copyWith(
                  textScaleFactor: constrainedTextScaleFactor,
                ),
                child: Scaffold(
                  body: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Builder(builder: (context) => widget),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
