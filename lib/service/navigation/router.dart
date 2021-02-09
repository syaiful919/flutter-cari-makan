import 'package:auto_route/auto_route_annotations.dart';
import 'package:carimakan/ui/pages/main_page/main_page.dart';
import 'package:carimakan/ui/pages/food_detail_page/food_detail_page.dart';
import 'package:carimakan/ui/pages/sign_in_page/sign_in_page.dart';
import 'package:carimakan/ui/pages/sign_up_page/sign_up_page.dart';
import 'package:carimakan/ui/pages/address_page/address_page.dart';
import 'package:carimakan/ui/pages/checkout_page/checkout_page.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  MainPage mainPage;
  FoodDetailPage foodDetailPage;
  SignInPage signInPage;
  SignUpPage signUpPage;
  AddressPage addressPage;
  CheckoutPage checkoutPage;
}
