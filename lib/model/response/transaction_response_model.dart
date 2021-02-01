import 'dart:convert';

import 'package:carimakan/model/response/metadata_model.dart';
import 'package:carimakan/model/entity/transaction_model.dart';

TransactionResponseModel transactionResponseModelFromJson(String str) =>
    TransactionResponseModel.fromJson(json.decode(str));

class TransactionResponseModel {
  TransactionResponseModel({
    this.meta,
    this.data,
  });

  MetadataModel meta;
  TransactionResponseDataModel data;

  factory TransactionResponseModel.fromJson(Map<String, dynamic> json) =>
      TransactionResponseModel(
        meta:
            json["meta"] == null ? null : MetadataModel.fromJson(json["meta"]),
        data: json["data"] == null
            ? null
            : TransactionResponseDataModel.fromJson(json["data"]),
      );
}

class TransactionResponseDataModel {
  TransactionResponseDataModel({
    this.currentPage,
    this.transactions,
    this.lastPage,
    this.perPage,
    this.total,
  });

  int currentPage;
  List<TransactionModel> transactions;
  int lastPage;
  int perPage;
  int total;

  factory TransactionResponseDataModel.fromJson(Map<String, dynamic> json) =>
      TransactionResponseDataModel(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        transactions: json["data"] == null
            ? null
            : List<TransactionModel>.from(
                json["data"].map((x) => TransactionModel.fromJson(x))),
        lastPage: json["last_page"] == null ? null : json["last_page"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        total: json["total"] == null ? null : json["total"],
      );
}
