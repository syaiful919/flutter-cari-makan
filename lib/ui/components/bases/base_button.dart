import 'package:carimakan/ui/components/bases/loading.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color color;
  final Color titleColor;
  final bool disabled;
  final bool loading;
  final bool outlineType;

  const BaseButton({
    Key key,
    @required this.onPressed,
    @required this.title,
    this.color,
    this.titleColor,
    this.disabled = false,
    this.loading = false,
    this.outlineType = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      child: loading
          ? Center(child: Loading())
          : RaisedButton(
              onPressed: disabled ? null : onPressed,
              color: outlineType
                  ? ProjectColor.white1
                  : (color ?? ProjectColor.main),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  side: outlineType
                      ? BorderSide(color: color ?? ProjectColor.black2)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(RadiusSize.m)),
              child: Text(
                title,
                style: TextStyle(
                  color: outlineType
                      ? (color ?? ProjectColor.black2)
                      : (titleColor ?? ProjectColor.black2),
                  fontSize: TypoSize.main,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
    );
  }
}
