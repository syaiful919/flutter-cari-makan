import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/ui/components/atom/custom_tabbar.dart';
import 'package:carimakan/ui/components/base/inner_listview.dart';
import 'package:carimakan/ui/components/base/loading.dart';
import 'package:carimakan/utils/project_images.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/utils/shared_value.dart';
import 'package:carimakan/viewmodel/order_history_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/ui/components/atom/illustration.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:carimakan/ui/components/atom/order_list_item.dart';

class OrderHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderHistoryViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: true,
      onModelReady: (model) => model.firstLoad(),
      viewModelBuilder: () => locator<OrderHistoryViewModel>(),
      builder: (_, model, __) => Scaffold(
        body: model.transactions == null
            ? Center(child: Loading())
            : model.transactions.length == 0
                ? Container(
                    color: ProjectColor.white1,
                    child: Illustration(
                      title: 'Ouch! Hungry',
                      subtitle: 'Seems you like have not\nordered any food yet',
                      picturePath: ProjectImages.loveBurger,
                      buttonTap1: () => model.goToHome(),
                      buttonTitle1: 'Find Foods',
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => model.firstLoad(),
                    child: ListView(
                      children: <Widget>[
                        HeaderSection(),
                        BodySection(),
                      ],
                    ),
                  ),
      ),
    );
  }
}

class BodySection extends HookViewModelWidget<OrderHistoryViewModel> {
  @override
  Widget buildViewModelWidget(context, model) {
    var selectedIndex = useState(0);
    double listItemWidth = MediaQuery.of(context).size.width - 2 * Gap.main;

    return Container(
      width: double.infinity,
      color: ProjectColor.white1,
      child: Column(
        children: [
          CustomTabBar(
            titles: ['In Progress', 'Past Orders'],
            selectedIndex: selectedIndex.value,
            onTap: (index) {
              selectedIndex.value = index;
            },
          ),
          SizedBox(height: Gap.m),
          Builder(builder: (context) {
            if (model.transactions != null) {
              List<TransactionModel> transactions = (selectedIndex.value == 0)
                  ? model.transactions
                      .where((x) =>
                          x.getStatus() == TransactionStatus.on_delivery ||
                          x.getStatus() == TransactionStatus.pending)
                      .toList()
                  : model.transactions
                      .where((x) =>
                          x.getStatus() == TransactionStatus.delivered ||
                          x.getStatus() == TransactionStatus.cancelled)
                      .toList();

              return (transactions.length == 0)
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: Gap.l, top: Gap.m),
                      child: Center(
                        child: Text("No orders yet", style: TypoStyle.mainGrey),
                      ),
                    )
                  : InnerListViewBuilder(
                      itemCount: transactions.length,
                      itemBuilder: (_, i) => Padding(
                        padding:
                            EdgeInsets.fromLTRB(Gap.main, 0, Gap.main, Gap.m),
                        child: OrderListItem(
                          transaction: transactions[i],
                          itemWidth: listItemWidth,
                          onTap: (val) => model.goToDetail(val),
                        ),
                      ),
                    );
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(Gap.main),
                  child: Loading(),
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      color: ProjectColor.white1,
      margin: EdgeInsets.only(bottom: Gap.main),
      padding: EdgeInsets.symmetric(horizontal: Gap.main),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Your Orders', style: TypoStyle.header1Black500),
          Text('Wait for the best meal', style: TypoStyle.mainGrey300)
        ],
      ),
    );
  }
}
