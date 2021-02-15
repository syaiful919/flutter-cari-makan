import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/request/sign_in_request_model.dart';
import 'package:carimakan/model/request/sign_up_request_model.dart';
import 'package:carimakan/model/request/update_user_request_model.dart';

import 'package:carimakan/model/response/user_response_model.dart';
import 'package:carimakan/network/api/http_client_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:carimakan/model/response/auth_response_model.dart';
import 'package:carimakan/model/response/sign_out_response_model.dart';

class UserApi {
  final _helper = locator<HttpClientHelper>();

  Future<UserResponseModel> getUser({@required String token}) async {
    var result = await _helper.get(endpoint: "user", bearerToken: token);
    return result == null ? null : UserResponseModel.fromJson(result);
  }

  Future<SignOutResponseModel> signOut({@required String token}) async {
    var result = await _helper.post(endpoint: "logout", bearerToken: token);
    return result == null ? null : SignOutResponseModel.fromJson(result);
  }

  Future<AuthResponseModel> signIn(
      {@required SignInRequestModel request}) async {
    var result = await _helper.post(
      endpoint: "login",
      body: signInRequestModelToJson(request),
    );
    return AuthResponseModel.fromJson(result);
  }

  Future<AuthResponseModel> signUp(
      {@required SignUpRequestModel request}) async {
    var result = await _helper.post(
      endpoint: "register",
      body: signUpRequestModelToJson(request),
    );
    return AuthResponseModel.fromJson(result);
  }

  Future<UserResponseModel> updateUser({
    @required UpdateUserRequestModel request,
    @required String token,
  }) async {
    var result = await _helper.post(
      endpoint: "user",
      body: updateUserRequestModelToJson(request),
      bearerToken: token,
    );
    return UserResponseModel.fromJson(result);
  }
}
