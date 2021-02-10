import 'package:carimakan/utils/project_theme.dart';
import 'package:flutter/material.dart';

class DetailListItem extends StatelessWidget {
  final String title;
  final String value;
  final Color valueColor;

  const DetailListItem({
    Key key,
    this.title,
    this.value,
    this.valueColor = ProjectColor.black2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width / 2 - Gap.main - 5,
            child: Text(title, style: TypoStyle.mainGrey)),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - Gap.main - 5,
          child: Text(
            value,
            style: TextStyle(color: valueColor, fontSize: TypoSize.main),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}
