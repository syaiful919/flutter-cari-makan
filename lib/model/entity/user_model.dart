class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.address,
    this.houseNumber,
    this.phoneNumber,
    this.city,
    this.profilePhotoUrl,
  });

  int id;
  String name;
  String email;
  String address;
  String houseNumber;
  String phoneNumber;
  String city;
  String profilePhotoUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        address: json["address"] == null ? null : json["address"],
        houseNumber: json["houseNumber"] == null ? null : json["houseNumber"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        city: json["city"] == null ? null : json["city"],
        profilePhotoUrl: json["profile_photo_url"] == null
            ? null
            : json["profile_photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "address": address == null ? null : address,
        "houseNumber": houseNumber == null ? null : houseNumber,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "city": city == null ? null : city,
        "profile_photo_url": profilePhotoUrl == null ? null : profilePhotoUrl,
      };
}
