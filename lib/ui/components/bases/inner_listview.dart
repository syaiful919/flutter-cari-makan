import 'package:flutter/material.dart';

class InnerListViewBuilder extends StatelessWidget {
  final int itemCount;
  final Function(BuildContext, int) itemBuilder;
  final EdgeInsetsGeometry padding;
  final Axis scrollDirection;

  const InnerListViewBuilder({
    Key key,
    @required this.itemCount,
    @required this.itemBuilder,
    this.padding,
    this.scrollDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: padding ?? EdgeInsets.zero,
      scrollDirection: scrollDirection ?? Axis.vertical,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}

class InnerListView extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final Axis scrollDirection;
  final List<Widget> children;

  const InnerListView({
    Key key,
    this.padding,
    this.scrollDirection,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: padding ?? EdgeInsets.zero,
      scrollDirection: scrollDirection ?? Axis.vertical,
      children: children,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
