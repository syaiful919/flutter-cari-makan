import 'dart:convert';

String checkoutRequestModelToJson(CheckoutRequestModel data) =>
    json.encode(data.toJson());

class CheckoutRequestModel {
  CheckoutRequestModel({
    this.foodId,
    this.userId,
    this.quantity,
    this.total,
    this.status,
  });

  int foodId;
  int userId;
  int quantity;
  int total;
  String status;

  Map<String, dynamic> toJson() => {
        "food_id": foodId,
        "user_id": userId,
        "quantity": quantity,
        "total": total,
        "status": status,
      };
}
