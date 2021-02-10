import 'package:carimakan/model/entity/transaction_model.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/utils/shared_value.dart';
import 'package:flutter/material.dart';
import 'package:carimakan/extension/extended_num.dart';

class OrderListItem extends StatelessWidget {
  final TransactionModel transaction;
  final double itemWidth;

  OrderListItem({@required this.transaction, @required this.itemWidth});

  @override
  Widget build(BuildContext context) {
    return Row(
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
                convertDateTime(transaction.createdAt),
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
    );
  }

  String convertDateTime(DateTime dateTime) {
    String month;

    switch (dateTime.month) {
      case 1:
        month = 'Jan';
        break;
      case 2:
        month = 'Feb';
        break;
      case 3:
        month = 'Mar';
        break;
      case 4:
        month = 'Apr';
        break;
      case 5:
        month = 'May';
        break;
      case 6:
        month = 'Jun';
        break;
      case 7:
        month = 'Jul';
        break;
      case 8:
        month = 'Aug';
        break;
      case 9:
        month = 'Sep';
        break;
      case 10:
        month = 'Oct';
        break;
      case 11:
        month = 'Nov';
        break;
      default:
        month = 'Des';
    }

    return month + ' ${dateTime.day}, ${dateTime.hour}:${dateTime.minute}';
  }
}
