import 'package:carimakan/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(),
      viewModelBuilder: () => HomeViewModel(),
      builder: (_, model, __) => Scaffold(
        body: Center(
          child: Text(
            "Home Page",
          ),
        ),
      ),
    );
  }
}
