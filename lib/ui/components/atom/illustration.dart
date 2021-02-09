import 'package:carimakan/utils/project_theme.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            margin: EdgeInsets.only(bottom: Gap.xl),
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(picturePath))),
          ),
          Text(
            title,
            style: TypoStyle.header2Black,
          ),
          Text(
            subtitle,
            style: TypoStyle.mainGrey300,
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.only(top: Gap.l, bottom: Gap.s),
            width: 200,
            height: 45,
            child: RaisedButton(
              onPressed: buttonTap1,
              color: ProjectColor.main,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RadiusSize.m)),
              child: Text(
                buttonTitle1,
                style: TypoStyle.mainBlack500,
              ),
            ),
          ),
          (buttonTap2 == null)
              ? SizedBox()
              : SizedBox(
                  width: 200,
                  height: 45,
                  child: RaisedButton(
                    onPressed: buttonTap2,
                    color: ProjectColor.grey2,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(RadiusSize.m)),
                    child: Text(
                      buttonTitle2 ?? 'title',
                      style: TypoStyle.mainWhite500,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
