import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/model/response/transaction_response_model.dart';
import 'package:carimakan/repository/transaction_repository.dart';
import 'package:carimakan/repository/user_repository.dart';

class OrderHistoryViewModel extends BaseViewModel {
  final _nav = locator<NavigationService>();
  final _transactionRepo = locator<TransactionRepository>();
  final _userRepo = locator<UserRepository>();

  String userToken;

  List<TransactionModel> transactions;

  Future<void> firstLoad() async {
    await getUserToken();
    if (userToken != null) runBusyFuture(getTransaction());
  }

  Future<void> getUserToken() async {
    try {
      userToken = _userRepo.getUserToken();
    } catch (e) {
      print(">>> get user token error $e");
    }
  }

  Future<void> getTransaction() async {
    try {
      TransactionResponseModel result =
          await _transactionRepo.getTransaction(token: userToken);
      if (result.data.transactions.length > 0) {
        transactions = result.data.transactions;
      }
    } catch (e) {
      print(">>> get transaction error: $e");
    }
  }

  void goBack() => _nav.pop();
}
