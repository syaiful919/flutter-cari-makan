import 'package:carimakan/model/request/sign_up_request_model.dart';
import 'package:carimakan/ui/components/template/general.dart';
import 'package:carimakan/viewmodel/address_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddressPage extends StatelessWidget {
  final SignUpRequestModel signUpRequest;

  const AddressPage({Key key, this.signUpRequest}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddressViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => AddressViewModel(),
      builder: (_, model, __) => General(
        title: 'Address',
        subtitle: "Make sure it's valid",
      ),
    );
  }
}
