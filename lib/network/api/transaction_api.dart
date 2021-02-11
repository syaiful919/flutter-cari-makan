import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/response/transactions_response_model.dart';
import 'package:carimakan/model/response/transaction_response_model.dart';

import 'package:carimakan/model/response/checkout_response_model.dart';
import 'package:carimakan/model/request/checkout_request_model.dart';

import 'package:carimakan/network/api/http_client_helper.dart';
import 'package:flutter/foundation.dart';

class TransactionApi {
  final _helper = locator<HttpClientHelper>();

  Future<TransactionsResponseModel> getTransactions(
      {@required String token}) async {
    var result =
        await _helper.get(endpoint: "transaction?limit=50", bearerToken: token);
    return TransactionsResponseModel.fromJson(result);
  }

  Future<TransactionResponseModel> getTransactionById(
      {@required String token, @required int id}) async {
    var result =
        await _helper.get(endpoint: "transaction?id=$id", bearerToken: token);
    return TransactionResponseModel.fromJson(result);
  }

  Future<CheckoutResponseModel> checkout({
    @required CheckoutRequestModel request,
    @required String token,
  }) async {
    var result = await _helper.post(
      endpoint: "checkout",
      body: checkoutRequestModelToJson(request),
      bearerToken: token,
    );
    return CheckoutResponseModel.fromJson(result);
  }
}
