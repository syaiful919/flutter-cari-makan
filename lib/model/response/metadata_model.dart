class MetadataModel {
  MetadataModel({
    this.code,
    this.status,
    this.message,
  });

  int code;
  String status;
  String message;

  factory MetadataModel.fromJson(Map<String, dynamic> json) => MetadataModel(
        code: json["code"] == null ? null : json["code"],
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
      );
}
