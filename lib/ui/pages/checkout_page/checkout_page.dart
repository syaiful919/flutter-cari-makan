import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/ui/components/bases/base_button.dart';
import 'package:carimakan/ui/components/atoms/detail_list_item.dart';

import 'package:carimakan/ui/components/bases/shrink_column.dart';
import 'package:carimakan/ui/components/templates/general.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/viewmodel/checkout_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/extension/extended_num.dart';

class CheckoutPage extends StatelessWidget {
  final TransactionModel transaction;

  const CheckoutPage({Key key, this.transaction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckoutViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(
        context: context,
        transaction: transaction,
      ),
      viewModelBuilder: () => CheckoutViewModel(),
      builder: (_, model, __) => General(
        title: 'Payment',
        subtitle: 'You deserve better meal',
        onBackButtonPressed: () => model.goBack(),
        child: Container(
          color: ProjectColor.white2,
          child: Column(
            children: <Widget>[
              if (model.transaction != null) ItemSection(),
              if (model.user != null) AddressSection(),
              if (model.transaction != null && model.user != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      Gap.main, Gap.zero, Gap.main, Gap.main),
                  child: BaseButton(
                    onPressed: () => model.checkout(),
                    loading: model.tryingToCheckout,
                    title: "Checkout Now",
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemSection extends ViewModelWidget<CheckoutViewModel> {
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

class AddressSection extends ViewModelWidget<CheckoutViewModel> {
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
          DetailListItem(title: "Name", value: model.user.name),
          SizedBox(height: Gap.xs),
          DetailListItem(title: "Phone No", value: model.user.phoneNumber),
          SizedBox(height: Gap.xs),
          DetailListItem(title: "Address", value: model.user.address),
          SizedBox(height: Gap.xs),
          DetailListItem(title: "House No", value: model.user.houseNumber),
          SizedBox(height: Gap.xs),
          DetailListItem(title: "City", value: model.user.city),
        ],
      ),
    );
  }
}
