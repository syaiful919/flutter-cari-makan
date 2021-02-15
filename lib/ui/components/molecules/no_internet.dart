import 'package:carimakan/ui/components/atoms/illustration.dart';
import 'package:carimakan/utils/project_images.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  final VoidCallback reloadAction;

  const NoInternet({Key key, this.reloadAction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Illustration(
      title: 'Oops!',
      subtitle: 'it looks like your internet connection has a problem',
      picturePath: ProjectImages.noInternet,
      buttonTap1: reloadAction,
      buttonTitle1: 'Reload',
    );
  }
}
