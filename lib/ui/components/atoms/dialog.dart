import 'package:carimakan/ui/components/bases/base_button.dart';
import 'package:carimakan/ui/components/bases/shrink_column.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:flutter/material.dart';

enum DialogAction { yes, no, none }

class Dialogs {
  static Future<DialogAction> yesNoDialog({
    @required BuildContext context,
    String title,
    String subtitle,
    String btnYesTitle,
    String btnNoTitle,
    bool isReverse = false,
  }) async {
    final action = await showDialog(
        context: context,
        useRootNavigator: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pop(DialogAction.none);
              return true;
            },
            child: BaseDialog(
              title: title,
              subtitle: subtitle,
              singleButton: false,
              isReverse: isReverse,
              btnYesTitle: btnYesTitle,
              yesAction: () => Navigator.of(context).pop(DialogAction.yes),
              btnNoTitle: btnNoTitle,
              noAction: () => Navigator.of(context).pop(DialogAction.no),
            ),
          );
        });
    return action ?? DialogAction.none;
  }

  static Future<DialogAction> okDialog({
    @required BuildContext context,
    String title,
    String subtitle,
    String btnTitle,
  }) async {
    final action = await showDialog(
        context: context,
        useRootNavigator: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pop(DialogAction.none);
              return true;
            },
            child: BaseDialog(
              title: title,
              subtitle: subtitle,
              btnOkTitle: btnTitle,
              okAction: () => Navigator.of(context).pop(DialogAction.yes),
            ),
          );
        });
    return action ?? DialogAction.none;
  }
}

class BaseDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback yesAction;
  final VoidCallback noAction;
  final VoidCallback okAction;

  final String btnYesTitle;
  final String btnNoTitle;
  final String btnOkTitle;
  final bool singleButton;

  final bool isReverse;

  const BaseDialog({
    Key key,
    this.title,
    this.subtitle,
    this.yesAction,
    this.noAction,
    this.btnYesTitle,
    this.btnNoTitle,
    this.btnOkTitle,
    this.singleButton = true,
    this.okAction,
    this.isReverse = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusSize.m),
      ),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusSize.m),
        ),
        padding: const EdgeInsets.fromLTRB(Gap.m, Gap.l, Gap.m, Gap.m),
        child: ShrinkColumn(
          children: <Widget>[
            if (title != null)
              Text(
                title,
                style: TypoStyle.titleBlack500,
                textAlign: TextAlign.center,
              ),
            if (title != null) SizedBox(height: Gap.m),
            if (title != null && subtitle == null)
              SizedBox(height: Gap.m + Gap.s),
            if (subtitle != null)
              Text(
                subtitle,
                style: TypoStyle.mainGrey,
                textAlign: TextAlign.center,
              ),
            if (subtitle != null) SizedBox(height: Gap.m),
            if (singleButton)
              SizedBox(
                width: 150,
                child: BaseButton(
                  title: btnOkTitle ?? "OK",
                  onPressed: () => okAction(),
                ),
              ),
            if (!singleButton)
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: BaseButton(
                        title: isReverse
                            ? (btnYesTitle ?? "YES")
                            : (btnNoTitle ?? "NO"),
                        onPressed: () {
                          isReverse ? yesAction() : noAction();
                        },
                        color: ProjectColor.grey2,
                        titleColor: ProjectColor.white1,
                      ),
                    ),
                    SizedBox(width: Gap.m),
                    Expanded(
                      child: BaseButton(
                        title: isReverse
                            ? (btnNoTitle ?? "NO")
                            : (btnYesTitle ?? "YES"),
                        onPressed: () {
                          isReverse ? noAction() : yesAction();
                        },
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
