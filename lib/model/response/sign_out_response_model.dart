import 'package:carimakan/model/response/metadata_model.dart';

class SignOutResponseModel {
  SignOutResponseModel({
    this.meta,
    this.data,
  });

  MetadataModel meta;
  bool data;

  factory SignOutResponseModel.fromJson(Map<String, dynamic> json) =>
      SignOutResponseModel(
        meta:
            json["meta"] == null ? null : MetadataModel.fromJson(json["meta"]),
        data: json["data"] == null ? null : json["data"],
      );
}
