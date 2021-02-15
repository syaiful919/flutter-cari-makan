import 'package:carimakan/ui/components/atoms/illustration.dart';
import 'package:carimakan/utils/project_images.dart';
import 'package:flutter/material.dart';

class SomethingError extends StatelessWidget {
  final VoidCallback reloadAction;

  const SomethingError({Key key, this.reloadAction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Illustration(
      title: 'Oops!',
      subtitle: 'there is something wrong',
      picturePath: ProjectImages.somethingWrong,
      buttonTap1: reloadAction,
      buttonTitle1: 'Reload',
    );
  }
}
