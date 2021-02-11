import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/service/navigation/navigation_service.dart';
import 'package:carimakan/service/navigation/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/model/response/transactions_response_model.dart';
import 'package:carimakan/repository/transaction_repository.dart';
import 'package:carimakan/repository/user_repository.dart';
import 'package:carimakan/viewmodel/main_viewmodel.dart';
import 'package:carimakan/utils/stream_key.dart';

class OrderHistoryViewModel extends MultipleStreamViewModel {
  final _nav = locator<NavigationService>();
  final _transactionRepo = locator<TransactionRepository>();
  final _userRepo = locator<UserRepository>();
  final _mainVM = locator<MainViewModel>();

  @override
  Map<String, StreamData> get streamsMap => {
        StreamKey.transactionReload:
            StreamData<bool>(_transactionRepo.isNeedReloadTransaction),
        StreamKey.authStatus: StreamData<bool>(_userRepo.isLogin),
      };

  @override
  void onData(String key, data) {
    super.onData(key, data);
    if (key == StreamKey.transactionReload) {
      if (data) {
        _transactionRepo.setIsNeedReloadTransaction(false);
        if (transactions != null) firstLoad();
      }
    }
  }

  String userToken;

  List<TransactionModel> transactions;

  Future<void> firstLoad() async {
    await getUserToken();
    if (userToken != null) {
      runBusyFuture(getTransaction());
    } else {
      logout();
    }
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
      TransactionsResponseModel result =
          await _transactionRepo.getTransactions(token: userToken);
      if (result.data.transactions != null) {
        transactions = result.data.transactions.reversed.toList();
      }
    } catch (e) {
      print(">>> get transaction error: $e");
    }
  }

  void logout() {
    _userRepo.logout();
    goToHome();
  }

  void goToDetail(TransactionModel transaction) {
    _nav.pushNamed(
      Routes.orderDetailPage,
      arguments: OrderDetailPageArguments(transaction: transaction),
    );
  }

  void goToHome() => _mainVM.setIndex(0);
}
