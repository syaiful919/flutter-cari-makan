import 'package:carimakan/ui/components/bases/base_button.dart';
import 'package:carimakan/ui/components/bases/shrink_column.dart';
import 'package:carimakan/ui/components/templates/general.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:carimakan/viewmodel/edit_address_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';
import 'package:carimakan/ui/components/bases/base_input.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class EditAddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditAddressViewModel>.reactive(
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => EditAddressViewModel(),
      builder: (_, model, __) => General(
        title: 'Address',
        subtitle: "Make sure it's valid",
        onBackButtonPressed: () => model.goBack(),
        child: model.user == null ? Container() : BodySection(),
      ),
    );
  }
}

class BodySection extends HookViewModelWidget<EditAddressViewModel> {
  @override
  Widget buildViewModelWidget(context, model) {
    var phoneController =
        useTextEditingController(text: model.user.phoneNumber);
    var addressController = useTextEditingController(text: model.user.address);
    var houseController =
        useTextEditingController(text: model.user.houseNumber);

    return Padding(
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
            selectedValue: model.user.city,
          ),
          SizedBox(height: Gap.main),
          BaseButton(
            title: "Update Address",
            onPressed: () => model.updateAddress(),
            loading: model.tryingToUpdateAddress,
          ),
        ],
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
