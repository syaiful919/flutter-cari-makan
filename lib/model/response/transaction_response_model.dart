import 'package:carimakan/model/response/metadata_model.dart';
import 'package:carimakan/model/entity/transaction_model.dart';

class TransactionResponseModel {
  TransactionResponseModel({
    this.meta,
    this.data,
  });

  MetadataModel meta;
  TransactionModel data;

  factory TransactionResponseModel.fromJson(Map<String, dynamic> json) =>
      TransactionResponseModel(
        meta:
            json["meta"] == null ? null : MetadataModel.fromJson(json["meta"]),
        data: json["data"] == null
            ? null
            : TransactionModel.fromJson(json["data"]),
      );
}
