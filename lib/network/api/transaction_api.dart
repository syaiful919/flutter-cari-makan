import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/response/transaction_response_model.dart';
import 'package:carimakan/network/api/http_client_helper.dart';
import 'package:flutter/foundation.dart';

class TransactionApi {
  final _helper = locator<HttpClientHelper>();

  Future<TransactionResponseModel> getTransaction(
      {@required String token}) async {
    var result = await _helper.get(endpoint: "transaction", bearerToken: token);
    return TransactionResponseModel.fromJson(result);
  }
}
