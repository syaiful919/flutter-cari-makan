import 'package:carimakan/model/entity/food_model.dart';
import 'package:carimakan/ui/components/atom/rating_stars.dart';
import 'package:carimakan/ui/components/base/base_button.dart';

import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/viewmodel/food_detail_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/extension/extended_num.dart';

class FoodDetailPage extends StatelessWidget {
  final FoodModel food;

  const FoodDetailPage({Key key, this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FoodDetailViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context, food: food),
      viewModelBuilder: () => FoodDetailViewModel(),
      builder: (_, model, __) => Scaffold(
        body: Stack(
          children: [
            Container(color: ProjectColor.main),
            SafeArea(child: Container(color: ProjectColor.white1)),
            SafeArea(
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(model.food.picturePath),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SafeArea(
              child: ListView(
                children: [
                  //// Back Button
                  Container(
                    height: 100,
                    padding: EdgeInsets.symmetric(horizontal: Gap.main),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => model.goBack(),
                        child: Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(RadiusSize.m),
                              color: ProjectColor.black1.withOpacity(0.12)),
                          child: Icon(Icons.arrow_back_ios,
                              color: ProjectColor.white1),
                        ),
                      ),
                    ),
                  ),
                  //// Body
                  Container(
                    margin: EdgeInsets.only(top: 180),
                    padding: EdgeInsets.symmetric(
                        vertical: Gap.main, horizontal: Gap.m),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(RadiusSize.xl),
                            topRight: Radius.circular(RadiusSize.xl)),
                        color: ProjectColor.white1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width -
                                      134, // 32 + 102
                                  child: Text(
                                    model.food.name,
                                    style: TypoStyle.titleBlack500,
                                  ),
                                ),
                                SizedBox(height: Gap.xs),
                                RatingStars(model.food.rate)
                              ],
                            ),
                            Row(
                              children: [
                                MinPlusButton(
                                  onTap: () => model.decreaseQuantity(),
                                  enabled: model.quantity > 1,
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    model.quantity.toString(),
                                    textAlign: TextAlign.center,
                                    style: TypoStyle.titleBlack500,
                                  ),
                                ),
                                MinPlusButton(
                                  onTap: () => model.increaseQuantity(),
                                  isMin: false,
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              Gap.zero, Gap.s, Gap.zero, Gap.m),
                          child: Text(
                            model.food.description,
                            style: TypoStyle.mainGrey,
                          ),
                        ),
                        Text('Ingredients:', style: TypoStyle.mainBlack),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              Gap.zero, Gap.xxs, Gap.zero, Gap.xl),
                          child: Text(
                            model.food.ingredients,
                            style: TypoStyle.mainGrey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Price',
                                  style: TypoStyle.secondaryGrey,
                                ),
                                Text(
                                  (model.quantity * model.food.price)
                                      .addCurrency(),
                                  style: TypoStyle.header3Black500,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 163,
                              child: BaseButton(
                                title: 'Order Now',
                                onPressed: () => model.goToCheckoutPage(),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MinPlusButton extends StatelessWidget {
  final bool isMin;
  final VoidCallback onTap;
  final bool enabled;

  const MinPlusButton({
    Key key,
    this.isMin = true,
    this.onTap,
    this.enabled = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusSize.m),
          border: Border.all(
            width: RadiusSize.xs,
            color: ProjectColor.black1.withOpacity(enabled ? 1 : 0.5),
          ),
        ),
        child: Icon(
          isMin ? Icons.remove : Icons.add,
          color: ProjectColor.black1.withOpacity(enabled ? 1 : 0.5),
          size: IconSize.s,
        ),
      ),
    );
  }
}
