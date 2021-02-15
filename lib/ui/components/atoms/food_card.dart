import 'package:carimakan/utils/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:carimakan/model/entity/food_model.dart';
import 'package:carimakan/ui/components/atoms/rating_stars.dart';

class FoodCard extends StatelessWidget {
  final FoodModel food;
  final Function(FoodModel) onTap;

  FoodCard(this.food, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap(food);
      },
      child: Container(
        width: 200,
        height: 210,
        decoration: BoxDecoration(
          color: ProjectColor.white1,
          borderRadius: BorderRadius.circular(RadiusSize.m),
          boxShadow: [
            BoxShadow(
                spreadRadius: 3,
                blurRadius: 15,
                color: ProjectColor.black1.withOpacity(0.12))
          ],
        ),
        child: Column(
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(RadiusSize.m),
                    topRight: Radius.circular(RadiusSize.m)),
                image: DecorationImage(
                    image: NetworkImage(food.picturePath), fit: BoxFit.cover),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(Gap.s, Gap.s, Gap.s, Gap.xs),
              width: 200,
              child: Text(
                food.name,
                style: TypoStyle.titleBlack500,
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Gap.s),
              child: RatingStars(food.rate),
            )
          ],
        ),
      ),
    );
  }
}
