import 'package:carimakan/model/request/sign_up_request_model.dart';
import 'package:carimakan/ui/components/bases/base_button.dart';
import 'package:carimakan/ui/components/bases/shrink_column.dart';
import 'package:carimakan/ui/components/templates/general.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/viewmodel/address_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/ui/components/bases/base_input.dart';

class AddressPage extends StatefulWidget {
  final SignUpRequestModel signUpRequest;

  const AddressPage({Key key, this.signUpRequest}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController phoneController;
  TextEditingController addressController;
  TextEditingController houseController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    houseController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    addressController.dispose();
    houseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddressViewModel>.reactive(
      onModelReady: (model) =>
          model.firstLoad(context: context, request: widget.signUpRequest),
      viewModelBuilder: () => AddressViewModel(),
      builder: (_, model, __) => General(
        title: 'Address',
        subtitle: "Make sure it's valid",
        onBackButtonPressed: () => model.goBack(),
        child: Padding(
          padding: const EdgeInsets.all(Gap.main),
          child: ShrinkColumn(
            children: <Widget>[
              BaseInput(
                controller: phoneController,
                label: "Phone No",
                placeHolder: 'Type your phone number',
                onChanged: (val) => model.changePhone(val),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: Gap.main),
              BaseInput(
                controller: addressController,
                label: "Address",
                placeHolder: 'Type your address',
                minLines: 2,
                maxLines: 3,
                onChanged: (val) => model.changeAddress(val),
              ),
              SizedBox(height: Gap.main),
              BaseInput(
                controller: houseController,
                label: "House No",
                placeHolder: 'Type your house number',
                onChanged: (val) => model.changeHouse(val),
              ),
              SizedBox(height: Gap.main),
              StringDropdown(
                label: "City",
                items: model.cities,
                onChanged: (item) => model.changeCity(item),
                selectedValue: model.selectedCity,
              ),
              SizedBox(height: Gap.main),
              BaseButton(
                title: "Sign Up Now",
                onPressed: () => model.signUp(),
                loading: model.tryingToSignUp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StringDropdown extends StatelessWidget {
  final String selectedValue;
  final String label;
  final List<String> items;
  final Function(String) onChanged;

  const StringDropdown({
    Key key,
    this.selectedValue,
    this.items,
    this.onChanged,
    this.label,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ShrinkColumn.start(
      children: <Widget>[
        if (label != null)
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: Gap.xs),
            child: Text(label, style: TypoStyle.titleBlack500),
          ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: Gap.m),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RadiusSize.m),
              border: Border.all(color: ProjectColor.black1)),
          child: DropdownButton(
            value: selectedValue,
            isExpanded: true,
            iconEnabledColor: ProjectColor.black1,
            underline: SizedBox(),
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: TypoStyle.mainBlack),
                  ),
                )
                .toList(),
            onChanged: (item) => onChanged(item),
          ),
        ),
      ],
    );
  }
}
