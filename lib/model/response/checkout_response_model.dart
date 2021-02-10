import 'dart:convert';

import 'package:carimakan/model/response/metadata_model.dart';

CheckoutResponseModel checkoutResponseModelFromJson(String str) =>
    CheckoutResponseModel.fromJson(json.decode(str));

class CheckoutResponseModel {
  CheckoutResponseModel({
    this.meta,
    this.data,
  });

  MetadataModel meta;
  CheckoutResponseData data;

  factory CheckoutResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckoutResponseModel(
        meta:
            json["meta"] == null ? null : MetadataModel.fromJson(json["meta"]),
        data: json["data"] == null
            ? null
            : CheckoutResponseData.fromJson(json["data"]),
      );
}

class CheckoutResponseData {
  CheckoutResponseData({
    this.id,
    this.foodId,
    this.userId,
    this.quantity,
    this.total,
    this.status,
    this.paymentUrl,
    this.createdAt,
  });

  int id;
  int foodId;
  int userId;
  int quantity;
  int total;
  String status;
  String paymentUrl;
  DateTime createdAt;

  factory CheckoutResponseData.fromJson(Map<String, dynamic> json) {
    return CheckoutResponseData(
      id: json["id"] == null ? null : json["id"],
      foodId: json["food_id"] == null ? null : json["food_id"],
      userId: json["user_id"] == null ? null : json["user_id"],
      quantity: json["quantity"] == null ? null : json["quantity"],
      total: json["total"] == null ? null : json["total"],
      status: json["status"] == null ? null : json["status"],
      paymentUrl: json["payment_url"] == null ? null : json["payment_url"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(json['created_at']),
    );
  }
}
