import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/response/user_response_model.dart';
import 'package:carimakan/network/api/http_client_helper.dart';
import 'package:flutter/foundation.dart';

class UserApi {
  final _helper = locator<HttpClientHelper>();

  Future<UserResponseModel> getUser({@required String token}) async {
    var result = await _helper.get(endpoint: "user", bearerToken: token);
    return UserResponseModel.fromJson(result);
  }

  Future<void> signOut({@required String token}) async {
    await _helper.post(endpoint: "logout", bearerToken: token);
  }
}
