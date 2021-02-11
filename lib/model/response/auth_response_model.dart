import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/model/response/metadata_model.dart';

class AuthResponseModel {
  AuthResponseModel({
    this.meta,
    this.data,
  });

  MetadataModel meta;
  SignInResponseData data;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      AuthResponseModel(
        meta:
            json["meta"] == null ? null : MetadataModel.fromJson(json["meta"]),
        data: json["data"] == null
            ? null
            : SignInResponseData.fromJson(json["data"]),
      );
}

class SignInResponseData {
  SignInResponseData({
    this.accessToken,
    this.user,
  });

  String accessToken;
  UserModel user;

  factory SignInResponseData.fromJson(Map<String, dynamic> json) =>
      SignInResponseData(
        accessToken: json["access_token"] == null ? null : json["access_token"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      );
}
