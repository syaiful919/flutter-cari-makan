import 'dart:io';

import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/model/request/update_user_request_model.dart';
import 'package:carimakan/model/response/user_response_model.dart';
import 'package:carimakan/repository/user_repository.dart';
import 'package:carimakan/service/flushbar/flushbar_service.dart';
import 'package:carimakan/service/image_picker/image_picker_service.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/extension/extended_string.dart';

class EditProfileViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _imagePicker = locator<ImagePickerService>();
  final _flush = locator<FlushbarService>();

  final _userRepo = locator<UserRepository>();

  BuildContext _pageContext;
  String _userToken;
  UserModel _user;
  UserModel get user => _user;

  File _image;
  File get image => _image;

  bool _tryingToUpdateProfile = false;
  bool get tryingToUpdateProfile => _tryingToUpdateProfile;

  Future<void> firstLoad({
    BuildContext context,
  }) async {
    if (_pageContext == null && context != null) _pageContext = context;
    await runBusyFuture(getUserToken());
    await runBusyFuture(getUser());
  }

  Future<void> getUserToken() async {
    try {
      _userToken = _userRepo.getUserToken();
    } catch (e) {
      print(">>> get user token error $e");
    }
  }

  Future<void> getUser() async {
    try {
      _user = _userRepo.getUserData();
      if (_user == null) {
        UserResponseModel response =
            await _userRepo.getUserDataRemote(token: _userToken);
        if (response.data != null) {
          _user = response.data;
          _userRepo.saveUserData(response.data);
        }
      }
    } catch (e) {
      print(">>> get user data error $e");
    }
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

  void changeName(String val) {
    _user.name = val;
    notifyListeners();
  }

  Future<void> updateProfile() async {
    if (_user.name.isNotSafety()) {
      _flush.showFlushbar(
        context: _pageContext,
        message: "Name can't be empty",
      );
    } else {
      updateProfileAction();
    }
  }

  Future<void> updateProfileAction() async {
    try {
      toggleTryingToUpdateProfile();
      UpdateUserRequestModel request = UpdateUserRequestModel(name: user.name);
      UserResponseModel response =
          await _userRepo.updateUser(request: request, token: _userToken);
      await afterSignUp(response);
    } catch (e) {
      print(">>> update profile error $e");
      _flush.showFlushbar(
          context: _pageContext, message: "Update profile failed");
    } finally {
      toggleTryingToUpdateProfile();
    }
  }

  Future<void> afterSignUp(UserResponseModel response) async {
    _user = response.data;

    if (_image != null) {
      String photoUrl = await uploadImage();
      if (photoUrl != null) _user.profilePhotoUrl = photoUrl;
    }

    _userRepo.saveUserData(_user);
    _userRepo.setIsProfileUpdated(true);
    goBack();
  }

  Future<String> uploadImage() async {
    try {
      String result = await _userRepo.uploadPhotoProfile(
        image: _image,
        token: _userToken,
      );
      return result;
    } catch (e) {
      print(">>> error $e");
      return null;
    }
  }

  void toggleTryingToUpdateProfile() {
    _tryingToUpdateProfile = !_tryingToUpdateProfile;
    notifyListeners();
  }

  void goBack() => _nav.pop(params: _user);
}
