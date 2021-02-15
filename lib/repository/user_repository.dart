import 'dart:convert';
import 'dart:io';

import 'package:carimakan/model/request/sign_up_request_model.dart';
import 'package:carimakan/model/response/user_response_model.dart';
import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/network/api/attachment_api.dart';

import 'package:carimakan/network/api/user_api.dart';
import 'package:carimakan/service/shared_preferences/pref_keys.dart';
import 'package:carimakan/service/shared_preferences/shared_preferences_service.dart';
import 'package:flutter/foundation.dart';
import 'package:carimakan/model/request/sign_in_request_model.dart';
import 'package:carimakan/model/request/update_user_request_model.dart';

import 'package:carimakan/locator/locator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:carimakan/model/response/auth_response_model.dart';
import 'package:carimakan/model/response/sign_out_response_model.dart';

class UserRepository {
  final UserApi _api = UserApi();
  final AttachmentApi _attachmentApi = AttachmentApi();

  Future<AuthResponseModel> signIn({@required SignInRequestModel request}) {
    return _api.signIn(request: request);
  }

  Future<AuthResponseModel> signUp({@required SignUpRequestModel request}) {
    return _api.signUp(request: request);
  }

  Future<UserResponseModel> updateUser({
    @required UpdateUserRequestModel request,
    @required String token,
  }) {
    return _api.updateUser(request: request, token: token);
  }

  Future<String> uploadPhotoProfile({
    @required File image,
    @required String token,
  }) {
    return _attachmentApi.uploadMedia(file: image, token: token);
  }

  Future<UserResponseModel> getUserDataRemote({@required String token}) {
    return _api.getUser(token: token);
  }

  final _sp = locator<SharedPreferencesService>();
  final BehaviorSubject<bool> _authController = BehaviorSubject<bool>();

  UserRepository() {
    _authController.add(false);
  }

  void setIsLogin(bool val) => _authController.sink.add(val);
  Stream<bool> get isLogin => _authController.stream;

  void saveUserData(UserModel userData) {
    _sp.putString(PrefKey.userData, json.encode(userData.toJson()));
  }

  UserModel getUserData() {
    String result = _sp.getString(PrefKey.userData);
    return result == null ? null : UserModel.fromJson(json.decode(result));
  }

  void saveUserToken(String token) => _sp.putString(PrefKey.userToken, token);
  String getUserToken() => _sp.getString(PrefKey.userToken);

  void removeUserData() => _sp.clearKey(PrefKey.userData);
  void removeUserToken() => _sp.clearKey(PrefKey.userToken);

  Future<void> removeSession({@required String token}) async {
    SignOutResponseModel result = await _api.signOut(token: token);
    print("session removed ${result?.data}");
  }

  void logout() {
    removeUserToken();
    removeUserData();
    setIsLogin(false);
    // removeSession(token: token);
  }
}
