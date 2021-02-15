import 'dart:convert';

String updateUserRequestModelToJson(UpdateUserRequestModel data) =>
    json.encode(data.toJson());

class UpdateUserRequestModel {
  UpdateUserRequestModel({
    this.name,
    this.email,
    this.address,
    this.city,
    this.houseNumber,
    this.phoneNumber,
  });

  String name;
  String email;
  String address;
  String city;
  String houseNumber;
  String phoneNumber;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> value = {};
    if (name != null) value['name'] = name;
    if (email != null) value['email'] = email;

    if (address != null) value['address'] = address;
    if (city != null) value['city'] = city;
    if (houseNumber != null) value['houseNumber'] = houseNumber;
    if (phoneNumber != null) value['phoneNumber'] = phoneNumber;

    return value;
  }
}
