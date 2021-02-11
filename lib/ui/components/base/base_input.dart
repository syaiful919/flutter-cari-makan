import 'package:carimakan/ui/components/base/shrink_column.dart';
import 'package:carimakan/utils/project_theme.dart';
import 'package:flutter/material.dart';

class BaseInput extends StatefulWidget {
  final TextEditingController controller;
  final String errorMessage;
  final String placeHolder;
  final bool showError;
  final bool autoFocus;
  final bool disabled;
  final bool passwordType;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final String label;

  const BaseInput({
    Key key,
    this.errorMessage,
    this.placeHolder = "",
    this.showError = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onSubmitted,
    @required this.controller,
    this.autoFocus = false,
    this.disabled = false,
    this.passwordType = false,
    this.label,
  }) : super(key: key);

  @override
  _BaseInputState createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  bool hideText;

  @override
  void initState() {
    super.initState();
    hideText = widget.passwordType;
  }

  @override
  Widget build(BuildContext context) {
    return ShrinkColumn.start(
      children: <Widget>[
        if (widget.label != null) InputLabel(title: widget.label),
        TextField(
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          autofocus: widget.autoFocus,
          enabled: !widget.disabled,
          obscureText: hideText,
          onChanged: (val) => widget.onChanged(val),
          onSubmitted: (val) => widget.onSubmitted(val),
          decoration: InputDecoration(
            suffixIcon: widget.passwordType
                ? GestureDetector(
                    onTap: () {
                      hideText = !hideText;
                      setState(() {});
                    },
                    child: Icon(
                      !hideText ? Icons.remove_red_eye : Icons.visibility_off,
                      color: ProjectColor.black1,
                      size: IconSize.m,
                    ),
                  )
                : null,
            contentPadding:
                const EdgeInsets.fromLTRB(Gap.m, Gap.s, Gap.m, Gap.s),
            hintText: widget.placeHolder,
            hintStyle: TypoStyle.mainGrey,
            counterText: "",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RadiusSize.m),
              borderSide: BorderSide(
                color:
                    widget.showError ? ProjectColor.red2 : ProjectColor.black1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RadiusSize.m),
              borderSide: BorderSide(
                color:
                    widget.showError ? ProjectColor.red2 : ProjectColor.green2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(RadiusSize.m),
              borderSide: BorderSide(color: ProjectColor.grey2),
            ),
          ),
        ),
        if (widget.showError) SizedBox(height: Gap.s),
        if (widget.showError) ErrorValidator(message: widget.errorMessage)
      ],
    );
  }
}

class InputLabel extends StatelessWidget {
  final String title;

  const InputLabel({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.xs),
      child: Text(title, style: TypoStyle.titleBlack500),
    );
  }
}

class ErrorValidator extends StatelessWidget {
  final String message;

  const ErrorValidator({this.message});

  @override
  Widget build(BuildContext context) {
    return SimpleValidator(message: message);
  }
}

class SimpleValidator extends StatelessWidget {
  final String message;

  const SimpleValidator({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(message, style: TypoStyle.smallRed),
    );
  }
}
