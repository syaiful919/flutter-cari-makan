import 'package:carimakan/model/response/transaction_response_model.dart';
import 'package:carimakan/network/api/transaction_api.dart';
import 'package:flutter/foundation.dart';

class TransactionRepository {
  final TransactionApi _api = TransactionApi();

  Future<TransactionResponseModel> getTransaction({@required String token}) {
    return _api.getTransaction(token: token);
  }
}
