import 'package:flutter/material.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/model/entity/food_model.dart';
import 'package:carimakan/ui/components/atom/rating_stars.dart';
import 'package:carimakan/extension/extended_num.dart';

class FoodListItem extends StatelessWidget {
  final FoodModel food;
  final Function(FoodModel) onTap;
  final double itemWidth;

  FoodListItem({@required this.food, @required this.itemWidth, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap(food);
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
                    image: NetworkImage(food.picturePath), fit: BoxFit.cover)),
          ),
          SizedBox(
            width: itemWidth - 182, // (60 + Gap.s (12) + 110)
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: TypoStyle.titleBlack500,
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
                Text(
                  food.price.addCurrency(),
                  style: TypoStyle.secondaryGrey,
                )
              ],
            ),
          ),
          RatingStars(food.rate)
        ],
      ),
    );
  }
}
