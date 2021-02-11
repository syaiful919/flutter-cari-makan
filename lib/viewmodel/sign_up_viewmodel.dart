import 'dart:io';

import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/request/sign_up_request_model.dart';
import 'package:carimakan/service/flushbar/flushbar_service.dart';
import 'package:carimakan/service/image_picker/image_picker_service.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:carimakan/utils/regex.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _flush = locator<FlushbarService>();
  final _imagePicker = locator<ImagePickerService>();

  BuildContext _pageContext;

  File _image;
  File get image => _image;

  String _email = "";
  String _password = "";
  String _name = "";

  Future<void> firstLoad({BuildContext context}) async {
    if (_pageContext == null && context != null) _pageContext = context;
  }

  void changeEmail(String val) {
    _email = val;
    notifyListeners();
  }

  void changePassword(String val) {
    _password = val;
    notifyListeners();
  }

  void changeName(String val) {
    _name = val;
    notifyListeners();
  }

  void openCamera() async {
    try {
      _image = await _imagePicker.getImageFromCamera();
      notifyListeners();
    } catch (e) {
      print(">>> error $e");
    }
  }

  void openGallery() async {
    try {
      _image = await _imagePicker.getImageFromGallery();
      notifyListeners();
    } catch (e) {
      print(">>> error $e");
    }
  }

  void goBack() => _nav.pop();

  void continueToAddressPage() {
    if (_name.isEmpty) {
      _flush.showFlushbar(
        context: _pageContext,
        message: "name can't be empty",
      );
    } else if (_email.isEmpty) {
      _flush.showFlushbar(
        context: _pageContext,
        message: "email can't be empty",
      );
    } else if (!emailRegExp.hasMatch(_email)) {
      _flush.showFlushbar(
        context: _pageContext,
        message: "email not valid",
      );
    } else if (_password.isEmpty) {
      _flush.showFlushbar(
        context: _pageContext,
        message: "password can't be empty",
      );
    } else {
      SignUpRequestModel request = SignUpRequestModel(
        name: _name,
        email: _email,
        password: _password,
        profilePicture: _image,
      );
      _nav.pushNamed(
        Routes.addressPage,
        arguments: AddressPageArguments(signUpRequest: request),
      );
    }
  }

  void goToSignInPage() {
    _nav.pushReplacementNamed(Routes.signInPage);
  }
}
