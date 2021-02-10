import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/model/response/metadata_model.dart';

class UserResponseModel {
  UserResponseModel({
    this.meta,
    this.data,
  });

  MetadataModel meta;
  UserModel data;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        meta:
            json["meta"] == null ? null : MetadataModel.fromJson(json["meta"]),
        data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
      );
}
