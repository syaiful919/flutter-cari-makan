import 'package:carimakan/locator/locator.dart';
import 'package:carimakan/model/entity/food_model.dart';
import 'package:carimakan/ui/components/base/inner_listview.dart';
import 'package:carimakan/ui/components/base/loading.dart';
import 'package:carimakan/ui/components/atom/custom_tabbar.dart';
import 'package:carimakan/ui/components/atom/food_card.dart';
import 'package:carimakan/ui/components/atom/food_list_item.dart';

import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/utils/shared_value.dart';

import 'package:carimakan/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: true,
      onModelReady: (model) => model.firstLoad(),
      viewModelBuilder: () => locator<HomeViewModel>(),
      builder: (_, model, __) {
        return Scaffold(
          // backgroundColor: ProjectColor.white1,
          body: ListView(
            children: [
              HeaderSection(),
              FoodListSection(),
              FoodTabSection(),
              SizedBox(height: 80)
            ],
          ),
        );
      },
    );
  }
}

class FoodTabSection extends HookViewModelWidget<HomeViewModel> {
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
            titles: ['New Taste', 'Popular', 'Recommended'],
            selectedIndex: selectedIndex.value,
            onTap: (index) {
              selectedIndex.value = index;
            },
          ),
          SizedBox(height: Gap.m),
          Builder(builder: (context) {
            if (model.foods != null) {
              List<FoodModel> foods = model.foods
                  .where((food) => food.getTypes().contains(
                      (selectedIndex.value == 0)
                          ? FoodType.new_food
                          : (selectedIndex.value == 1)
                              ? FoodType.popular
                              : FoodType.recommended))
                  .toList();

              return InnerListViewBuilder(
                itemCount: foods.length,
                itemBuilder: (_, i) => Padding(
                  padding: EdgeInsets.fromLTRB(Gap.main, 0, Gap.main, Gap.m),
                  child: FoodListItem(
                    food: foods[i],
                    itemWidth: listItemWidth,
                    onTap: (food) => model.goToFoodDetail(food),
                  ),
                ),
              );
            } else {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(Gap.main),
                child: Loading(),
              ));
            }
          }),
        ],
      ),
    );
  }
}

class FoodListSection extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(context, model) {
    return Container(
      height: 258,
      width: double.infinity,
      child: model.foods != null && model.foods.length > 0
          ? ListView.builder(
              itemCount: model.foods.length,
              itemBuilder: (_, i) => Padding(
                padding: EdgeInsets.fromLTRB(
                    i == 0 ? Gap.main : 0, Gap.main, Gap.main, Gap.main),
                child: FoodCard(
                  model.foods[i],
                  onTap: (food) => model.goToFoodDetail(food),
                ),
              ),
              scrollDirection: Axis.horizontal,
            )
          : Center(child: Loading()),
    );
  }
}

class HeaderSection extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(context, model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Gap.main),
      color: ProjectColor.white1,
      height: 100,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Food Market', style: TypoStyle.header1Black500),
              Text("Let's get some foods", style: TypoStyle.mainGrey300),
            ],
          ),
          if (model.user != null)
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(RadiusSize.m),
                image: DecorationImage(
                    image: NetworkImage(model.user.profilePhotoUrl),
                    fit: BoxFit.cover),
              ),
            )
        ],
      ),
    );
  }
}
