import 'dart:convert';

import 'dart:io';

String signUpRequestModelToJson(SignUpRequestModel data) =>
    json.encode(data.toJson());

class SignUpRequestModel {
  SignUpRequestModel({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.address,
    this.city,
    this.houseNumber,
    this.phoneNumber,
    this.profilePicture,
  });

  String name;
  String email;
  String password;
  String passwordConfirmation;
  String address;
  String city;
  String houseNumber;
  String phoneNumber;
  File profilePicture;

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "password_confirmation":
            passwordConfirmation == null ? null : passwordConfirmation,
        "address": address == null ? null : address,
        "city": city == null ? null : city,
        "houseNumber": houseNumber == null ? null : houseNumber,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
      };
}
