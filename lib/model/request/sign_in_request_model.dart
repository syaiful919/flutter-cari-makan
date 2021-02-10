import 'dart:convert';

String signInRequestModelToJson(SignInRequestModel data) =>
    json.encode(data.toJson());

class SignInRequestModel {
  SignInRequestModel({
    this.email,
    this.password,
  });

  String email;
  String password;

  Map<String, dynamic> toJson() => {
        "email": email == null ? null : email,
        "password": password == null ? null : password,
      };
}
