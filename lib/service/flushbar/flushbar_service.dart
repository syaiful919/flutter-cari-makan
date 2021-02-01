import 'package:carimakan/utils/project_theme.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushbarService {
  void showFlushbar({
    @required BuildContext context,
    @required String message,
    Duration duration = const Duration(milliseconds: 3000),
    Color color = ProjectColor.red2,
  }) {
    Flushbar(
      duration: duration,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color,
      message: message,
    )..show(context);
  }
}
