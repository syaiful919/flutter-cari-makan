import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/ui/components/atom/detail_list_item.dart';
import 'package:carimakan/ui/components/base/base_button.dart';
import 'package:carimakan/ui/components/base/loading.dart';
import 'package:carimakan/ui/components/base/shrink_column.dart';
import 'package:carimakan/ui/components/template/general.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/utils/shared_value.dart';
import 'package:carimakan/viewmodel/order_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/extension/extended_num.dart';
import 'package:carimakan/extension/extended_datetime.dart';

class OrderDetailPage extends StatelessWidget {
  final TransactionModel transaction;

  const OrderDetailPage({Key key, this.transaction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderDetailViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(
        context: context,
        transaction: transaction,
      ),
      viewModelBuilder: () => OrderDetailViewModel(),
      builder: (_, model, __) => Stack(
        children: <Widget>[
          General(
            title: 'Order Detail',
            subtitle: 'Your best choice',
            onBackButtonPressed: () => model.goBack(),
            child: Container(
              color: ProjectColor.white2,
              child: model.transaction == null
                  ? Container()
                  : Column(
                      children: <Widget>[
                        StatusSection(),
                        ItemSection(),
                        AddressSection(),
                        if (model.transaction.getStatus() ==
                            TransactionStatus.pending)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                Gap.main, Gap.zero, Gap.main, Gap.main),
                            child: BaseButton(
                              color: ProjectColor.red2,
                              titleColor: ProjectColor.white1,
                              onPressed: () => model.pay(),
                              title: "Continue Payment",
                            ),
                          )
                      ],
                    ),
            ),
          ),
          if (model.tryingToReload)
            Container(
              alignment: Alignment.center,
              color: ProjectColor.black1.withOpacity(0.5),
              child: Loading(),
            ),
        ],
      ),
    );
  }
}

class ItemSection extends ViewModelWidget<OrderDetailViewModel> {
  @override
  Widget build(context, model) {
    return Container(
      color: ProjectColor.white1,
      margin: EdgeInsets.only(bottom: Gap.main),
      padding: EdgeInsets.symmetric(horizontal: Gap.main, vertical: Gap.m),
      child: ShrinkColumn.start(
        children: <Widget>[
          Text('Item Ordered', style: TypoStyle.mainBlack),
          SizedBox(height: Gap.s),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.only(right: Gap.s),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(RadiusSize.m),
                        image: DecorationImage(
                            image: NetworkImage(
                                model.transaction.food.picturePath),
                            fit: BoxFit.cover)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 198,
                        // 2 * Gap.main (jarak border) +
                        // 60 (lebar picture) +
                        // 12 (jarak picture ke title)+
                        // 78 (lebar jumlah items),
                        child: Text(
                          model.transaction.food.name,
                          style: TypoStyle.titleBlack500,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      Text(
                        model.transaction.food.price.addCurrency(),
                        style: TypoStyle.mainGrey300,
                      )
                    ],
                  )
                ],
              ),
              Text(
                '${model.transaction.quantity} item(s)',
                style: TypoStyle.secondaryGrey,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: Gap.m, bottom: Gap.s),
            child: Text('Details Transaction', style: TypoStyle.mainBlack),
          ),
          DetailListItem(
            title: model.transaction.food.name,
            value: (model.transaction.food.price * model.transaction.quantity)
                .addCurrency(),
          ),
          SizedBox(height: Gap.xs),
          DetailListItem(
              title: "Driver", value: model.driverPrice.addCurrency()),
          SizedBox(height: Gap.xs),
          DetailListItem(title: "Tax 10%", value: model.taxPrice.addCurrency()),
          SizedBox(height: Gap.xs),
          DetailListItem(
            title: "Total Price",
            value: model.transaction.total.addCurrency(),
            valueColor: ProjectColor.green2,
          ),
        ],
      ),
    );
  }
}

class AddressSection extends ViewModelWidget<OrderDetailViewModel> {
  @override
  Widget build(context, model) {
    return Container(
      color: ProjectColor.white1,
      margin: EdgeInsets.only(bottom: Gap.main),
      padding: EdgeInsets.symmetric(horizontal: Gap.main, vertical: Gap.m),
      child: ShrinkColumn.start(
        children: <Widget>[
          Text('Deliver to', style: TypoStyle.mainBlack),
          SizedBox(height: Gap.s),
          DetailListItem(title: "Name", value: model.transaction.user.name),
          SizedBox(height: Gap.xs),
          DetailListItem(
              title: "Phone No", value: model.transaction.user.phoneNumber),
          SizedBox(height: Gap.xs),
          DetailListItem(
              title: "Address", value: model.transaction.user.address),
          SizedBox(height: Gap.xs),
          DetailListItem(
              title: "House No", value: model.transaction.user.houseNumber),
          SizedBox(height: Gap.xs),
          DetailListItem(title: "City", value: model.transaction.user.city),
        ],
      ),
    );
  }
}

class StatusSection extends ViewModelWidget<OrderDetailViewModel> {
  @override
  Widget build(context, model) {
    return Container(
      color: ProjectColor.white1,
      margin: EdgeInsets.only(bottom: Gap.main),
      padding: EdgeInsets.symmetric(horizontal: Gap.main, vertical: Gap.m),
      child: ShrinkColumn.start(
        children: <Widget>[
          Text('Order Status', style: TypoStyle.mainBlack),
          SizedBox(height: Gap.s),
          DetailListItem(title: "Order ID", value: "#${model.transaction.id}"),
          SizedBox(height: Gap.xs),
          DetailListItem(
              title: "Order date", value: model.transaction.createdAt.format()),
          SizedBox(height: Gap.xs),
          DetailListItem(
            title: "Status",
            value: model.transaction.status.toUpperCase(),
            valueColor:
                model.transaction.getStatus() == TransactionStatus.delivered ||
                        model.transaction.getStatus() ==
                            TransactionStatus.on_delivery
                    ? ProjectColor.green2
                    : ProjectColor.red2,
          ),
        ],
      ),
    );
  }
}
