import 'package:carimakan/network/api/http_client_helper.dart';
import 'package:carimakan/service/connectivity/connectivity_service.dart';
import 'package:carimakan/service/flushbar/flushbar_service.dart';
import 'package:carimakan/service/image_picker/image_picker_service.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/shared_preferences/shared_preferences_service.dart';
import 'package:carimakan/viewmodel/home_viewmodel.dart';
import 'package:carimakan/viewmodel/main_viewmodel.dart';
import 'package:carimakan/viewmodel/order_history_viewmodel.dart';
import 'package:carimakan/viewmodel/profile_viewmodel.dart';
import 'package:carimakan/repository/user_repository.dart';
import 'package:carimakan/repository/transaction_repository.dart';
import 'package:carimakan/repository/food_repository.dart';

import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // -------- SERVICE -------- //
  SharedPreferencesService sharedPreferencesService =
      await SharedPreferencesService.getInstance();
  locator.registerSingleton<SharedPreferencesService>(sharedPreferencesService);

  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<FlushbarService>(FlushbarService());
  locator.registerSingleton<ConnectivityService>(ConnectivityService());

  locator.registerSingleton<HttpClientHelper>(HttpClientHelper());
  locator.registerLazySingleton<ImagePickerService>(() => ImagePickerService());

  // -------- REPOSITORY -------- //
  locator.registerLazySingleton<UserRepository>(() => UserRepository());
  locator.registerLazySingleton<TransactionRepository>(
      () => TransactionRepository());
  locator.registerLazySingleton<FoodRepository>(() => FoodRepository());

  // -------- NON DISPOSABLE VIEWMODEL -------- //
  locator.registerSingleton<MainViewModel>(MainViewModel());

  locator.registerSingleton<HomeViewModel>(HomeViewModel());
  locator.registerSingleton<OrderHistoryViewModel>(OrderHistoryViewModel());
  locator.registerSingleton<ProfileViewModel>(ProfileViewModel());
}
