import 'package:carimakan/utils/project_theme.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> titles;
  final Function(int) onTap;

  CustomTabBar({@required this.titles, this.selectedIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: Gap.xl),
            height: 1,
            color: ProjectColor.grey3,
          ),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) => Padding(
              padding: EdgeInsets.only(left: Gap.main),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (onTap != null) {
                        onTap(i);
                      }
                    },
                    child: Text(
                      titles[i],
                      style: (i == selectedIndex)
                          ? TypoStyle.mainBlack500
                          : TypoStyle.mainGrey,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 3,
                    margin: EdgeInsets.only(top: Gap.s),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(RadiusSize.xs),
                        color: (i == selectedIndex)
                            ? ProjectColor.black2
                            : Colors.transparent),
                  )
                ],
              ),
            ),
            itemCount: titles.length,
          ),
        ],
      ),
    );
  }
}
