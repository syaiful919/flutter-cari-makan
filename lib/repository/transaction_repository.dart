import 'package:carimakan/model/response/transactions_response_model.dart';
import 'package:carimakan/model/response/transaction_response_model.dart';

import 'package:carimakan/network/api/transaction_api.dart';
import 'package:carimakan/model/request/checkout_request_model.dart';
import 'package:carimakan/model/response/checkout_response_model.dart';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class TransactionRepository {
  final TransactionApi _api = TransactionApi();

  final BehaviorSubject<bool> _transactionController = BehaviorSubject<bool>();

  TransactionRepository() {
    _transactionController.add(false);
  }

  void setIsNeedReloadTransaction(bool val) =>
      _transactionController.sink.add(val);
  Stream<bool> get isNeedReloadTransaction => _transactionController.stream;

  Future<TransactionsResponseModel> getTransactions({@required String token}) {
    return _api.getTransactions(token: token);
  }

  Future<TransactionResponseModel> getTransactionById({
    @required String token,
    @required int id,
  }) {
    return _api.getTransactionById(id: id, token: token);
  }

  Future<CheckoutResponseModel> checkout({
    @required CheckoutRequestModel request,
    @required String token,
  }) {
    return _api.checkout(request: request, token: token);
  }
}
