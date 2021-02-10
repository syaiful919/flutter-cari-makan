import 'package:carimakan/ui/components/base/shrink_column.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:carimakan/ui/components/base/base_button.dart';

class Illustration extends StatelessWidget {
  final String title;
  final String subtitle;
  final String picturePath;
  final String buttonTitle1;
  final String buttonTitle2;
  final Function buttonTap1;
  final Function buttonTap2;

  Illustration({
    @required this.title,
    @required this.subtitle,
    @required this.picturePath,
    @required this.buttonTap1,
    this.buttonTap2,
    @required this.buttonTitle1,
    this.buttonTitle2,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShrinkColumn(
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 2 * Gap.xl,
            margin: EdgeInsets.only(bottom: Gap.xl),
            child: Image.asset(
              picturePath,
              fit: BoxFit.fitHeight,
              height: 150,
            ),
          ),
          Text(title, style: TypoStyle.header2Black),
          Text(
            subtitle,
            style: TypoStyle.mainGrey300,
            textAlign: TextAlign.center,
          ),
          Container(
              margin: EdgeInsets.only(top: Gap.l, bottom: Gap.s),
              width: 200,
              child: BaseButton(
                onPressed: buttonTap1,
                title: buttonTitle1,
              )),
          (buttonTap2 != null && buttonTitle2 != null)
              ? SizedBox(
                  width: 200,
                  child: BaseButton(
                    onPressed: buttonTap2,
                    title: buttonTitle2,
                    color: ProjectColor.grey2,
                    titleColor: ProjectColor.white1,
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
