import 'package:carimakan/utils/project_theme.dart';
import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rate;

  RatingStars(this.rate);

  @override
  Widget build(BuildContext context) {
    int numberOfStars = rate.round();

    return Row(
      children: List<Widget>.generate(
            5,
            (index) => Icon(
              (index < numberOfStars) ? Icons.star : Icons.star_border,
              size: IconSize.s,
              color: ProjectColor.main,
            ),
          ) +
          [
            SizedBox(
              width: Gap.xxs,
            ),
            Text(
              rate.toString(),
              style: TypoStyle.secondaryGrey,
            )
          ],
    );
  }
}
