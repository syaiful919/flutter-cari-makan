import 'package:carimakan/utils/project_theme.dart';
import 'package:flutter/material.dart';

class General extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onBackButtonPressed;
  final Widget child;
  final Color backColor;

  General({
    @required this.title,
    @required this.subtitle,
    this.onBackButtonPressed,
    this.child,
    this.backColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(color: ProjectColor.white1),
        SafeArea(
            child: Container(
          color: backColor ?? ProjectColor.white1,
        )),
        SafeArea(
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Gap.main),
                    width: double.infinity,
                    height: 100,
                    color: ProjectColor.white1,
                    child: Row(
                      children: [
                        onBackButtonPressed != null
                            ? GestureDetector(
                                onTap: () {
                                  if (onBackButtonPressed != null) {
                                    onBackButtonPressed();
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: Gap.main),
                                  child: Icon(Icons.arrow_back_ios,
                                      color: ProjectColor.grey2),
                                ),
                              )
                            : SizedBox(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(title, style: TypoStyle.header1Black500),
                            Text(subtitle, style: TypoStyle.mainGrey300)
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: Gap.main,
                    width: double.infinity,
                    color: ProjectColor.white3,
                  ),
                  child ?? SizedBox()
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
