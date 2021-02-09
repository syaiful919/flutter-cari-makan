import 'package:carimakan/model/entity/food_model.dart';
import 'package:carimakan/model/entity/user_model.dart';
import 'package:carimakan/utils/shared_value.dart';

class TransactionModel {
  TransactionModel({
    this.id,
    this.foodId,
    this.userId,
    this.quantity,
    this.total,
    this.status,
    this.paymentUrl,
    this.food,
    this.user,
    this.createdAt,
  });

  int id;
  int foodId;
  int userId;
  int quantity;
  int total;
  String status;
  String paymentUrl;
  FoodModel food;
  UserModel user;
  DateTime createdAt;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"] == null ? null : json["id"],
        foodId: json["food_id"] == null ? null : json["food_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        total: json["total"] == null ? null : json["total"],
        status: json["status"] == null ? null : json["status"],
        paymentUrl: json["payment_url"] == null ? null : json["payment_url"],
        food: json["food"] == null ? null : FoodModel.fromJson(json["food"]),
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json['created_at']),
      );

  TransactionStatus getStatus() {
    return (status == 'PENDING')
        ? TransactionStatus.pending
        : (status == 'DELIVERED')
            ? TransactionStatus.delivered
            : (status == 'CANCELLED')
                ? TransactionStatus.cancelled
                : TransactionStatus.on_delivery;
  }
}
