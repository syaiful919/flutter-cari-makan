import 'package:flutter/material.dart';

class NonScallableContainer extends StatelessWidget {
  final Widget child;

  const NonScallableContainer({Key key, @required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: child,
    );
  }
}
