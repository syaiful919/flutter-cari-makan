import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();

  Future<void> firstLoad() async {}

  void goBack() => _nav.pop();
}
