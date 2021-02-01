import 'dart:convert';

import 'package:carimakan/model/entity/food_model.dart';
import 'package:carimakan/model/response/metadata_model.dart';

FoodResponseModel foodResponseModelFromJson(String str) =>
    FoodResponseModel.fromJson(json.decode(str));

class FoodResponseModel {
  FoodResponseModel({
    this.meta,
    this.data,
  });

  MetadataModel meta;
  FoodResponseDataModel data;

  factory FoodResponseModel.fromJson(Map<String, dynamic> json) =>
      FoodResponseModel(
        meta:
            json["meta"] == null ? null : MetadataModel.fromJson(json["meta"]),
        data: json["data"] == null
            ? null
            : FoodResponseDataModel.fromJson(json["data"]),
      );
}

class FoodResponseDataModel {
  FoodResponseDataModel({
    this.currentPage,
    this.foods,
    this.lastPage,
    this.perPage,
    this.total,
  });

  int currentPage;
  List<FoodModel> foods;
  int lastPage;
  int perPage;
  int total;

  factory FoodResponseDataModel.fromJson(Map<String, dynamic> json) =>
      FoodResponseDataModel(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        foods: json["data"] == null
            ? null
            : List<FoodModel>.from(
                json["data"].map((x) => FoodModel.fromJson(x))),
        lastPage: json["last_page"] == null ? null : json["last_page"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        total: json["total"] == null ? null : json["total"],
      );
}
