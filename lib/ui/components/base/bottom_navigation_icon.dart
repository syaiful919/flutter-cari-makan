import 'package:carimakan/utils/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationIcon extends StatelessWidget {
  final String iconPath;

  const BottomNavigationIcon(this.iconPath, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      width: IconSize.m,
      height: IconSize.m,
    );
  }
}
