import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/utils/shared_value.dart';
import 'package:flutter/material.dart';
import 'package:carimakan/extension/extended_num.dart';
import 'package:carimakan/extension/extended_datetime.dart';

class OrderListItem extends StatelessWidget {
  final Function(TransactionModel) onTap;
  final TransactionModel transaction;
  final double itemWidth;

  OrderListItem(
      {@required this.transaction, @required this.itemWidth, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(transaction);
      },
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            margin: EdgeInsets.only(right: Gap.s),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(RadiusSize.m),
                image: DecorationImage(
                    image: NetworkImage(transaction.food.picturePath),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            width: itemWidth - 182, // (60 + 12 + 110)
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.food.name,
                  style: TypoStyle.titleBlack500,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
                Text(
                  "${transaction.quantity} item(s) • " +
                      transaction.total.addCurrency(),
                  style: TypoStyle.secondaryGrey,
                )
              ],
            ),
          ),
          SizedBox(
            width: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transaction.createdAt.format(),
                  style: TypoStyle.secondaryGrey,
                ),
                (transaction.getStatus() == TransactionStatus.cancelled)
                    ? Text('Cancelled', style: TypoStyle.smallRed)
                    : (transaction.getStatus() == TransactionStatus.pending)
                        ? Text('Pending', style: TypoStyle.smallRed)
                        : (transaction.getStatus() ==
                                TransactionStatus.on_delivery)
                            ? Text('On Delivery', style: TypoStyle.smallGreen)
                            : SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }
}
