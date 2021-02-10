import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/repository/user_repository.dart';

class MainViewModel extends StreamViewModel {
  // ------ START OF INDEX TRACKING VIEWMODEL ------ //

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool _reverse = false;

  /// Indicates whether we're going forward or backward in terms of the index we're changing.
  /// This is very helpful for the page transition directions.
  bool get reverse => _reverse;

  void setIndex(int value) {
    if (value < _currentIndex) {
      _reverse = true;
    } else {
      _reverse = false;
    }
    _currentIndex = value;
    notifyListeners();
  }

  bool isIndexSelected(int index) => _currentIndex == index;

  // ------ END OF INDEX TRACKING VIEWMODEL ------ //
  final _nav = locator<NavigationService>();
  final _userRepo = locator<UserRepository>();

  String userToken;

  void firstLoad() {
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    await getUserToken();
    _userRepo.setIsLogin(userToken != null);
  }

  Future<void> getUserToken() async {
    try {
      userToken = _userRepo.getUserToken();
    } catch (e) {
      print(">>> get user token error: $e");
    }
  }

  void setPageIndex(int index) {
    if (index != 0 && !data) {
      goToSignInPage();
    } else {
      setIndex(index);
    }
  }

  void goToSignInPage() {
    _nav.pushNamed(Routes.signInPage);
  }

  @override
  Stream get stream => _userRepo.isLogin;
}
