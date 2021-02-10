import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/ui/components/base/base_button.dart';
import 'package:carimakan/ui/components/base/shrink_column.dart';
import 'package:carimakan/ui/components/template/general.dart';
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
          PriceItem(
            title: model.transaction.food.name,
            price: model.transaction.food.price * model.transaction.quantity,
          ),
          SizedBox(height: Gap.xs),
          PriceItem(title: "Driver", price: model.driverPrice),
          SizedBox(height: Gap.xs),
          PriceItem(title: "Tax 10%", price: model.taxPrice),
          SizedBox(height: Gap.xs),
          PriceItem(
            title: "Total Price",
            price: model.transaction.total,
            priceColor: ProjectColor.green2,
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
          AddressItem(title: "Name", value: model.user.name),
          SizedBox(height: Gap.xs),
          AddressItem(title: "Phone No", value: model.user.phoneNumber),
          SizedBox(height: Gap.xs),
          AddressItem(title: "Address", value: model.user.address),
          SizedBox(height: Gap.xs),
          AddressItem(title: "House No", value: model.user.houseNumber),
          SizedBox(height: Gap.xs),
          AddressItem(title: "City", value: model.user.city),
        ],
      ),
    );
  }
}

class PriceItem extends StatelessWidget {
  final String title;
  final int price;
  final Color priceColor;

  const PriceItem({
    Key key,
    this.title,
    this.price,
    this.priceColor = ProjectColor.black2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width / 2 - Gap.main - 5,
            child: Text(title, style: TypoStyle.mainGrey)),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - Gap.main - 5,
          child: Text(
            price.addCurrency(),
            style: TextStyle(color: priceColor, fontSize: TypoSize.main),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}

class AddressItem extends StatelessWidget {
  final String title;
  final String value;

  const AddressItem({Key key, this.title, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width / 2 - Gap.main - 5,
            child: Text(title, style: TypoStyle.mainGrey)),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - Gap.main - 5,
          child: Text(
            value,
            style: TypoStyle.mainBlack,
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}
