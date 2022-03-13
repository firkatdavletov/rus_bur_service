import 'package:flutter/material.dart';
import 'package:rus_bur_service/styles/text_style.dart';
import 'package:dropdownfield2/dropdownfield2.dart';

class AppTextFieldSaved extends StatelessWidget {
  final Function onSaved;
  final Function validator;
  final Icon icon;
  final String label;
  final String initialValue;
  final String helperText;
  const AppTextFieldSaved({
    Key? key,
    required this.onSaved,
    required this.validator,
    required this.icon,
    required this.label,
    required this.initialValue,
    required this.helperText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode appFocusNode = FocusNode();
    return TextFormField(
      initialValue: initialValue,
      onSaved: (value) => onSaved(value),
      validator: (value) => validator(value),
      style: AppTextStyle().getInputTextStyle(),
      decoration: InputDecoration(
        helperText: helperText,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black38,
                width: 1.5
            )
        ),
        icon: icon,
        label: Text(label),
        labelStyle: appFocusNode.hasFocus? AppTextStyle().getFocusedLabelStyle()
            : AppTextStyle().getInputLabelStyle(),
      ),
    );
  }
}

class AppDropDownFormField extends StatefulWidget {
  final Function onSaved;
  final String label;
  final String initialValue;
  final List<String> items;
  final int itemsVisible;
  const AppDropDownFormField({
    Key? key,
    required this.onSaved,
    required this.label,
    required this.initialValue,
    required this.items,
    required this.itemsVisible
  }) : super(key: key);

  @override
  _AppDropDownFormFieldState createState() => _AppDropDownFormFieldState();
}
class _AppDropDownFormFieldState extends State<AppDropDownFormField> {
  @override
  Widget build(BuildContext context) {
    FocusNode appFocusNode = FocusNode();
    return DropDownField(
      value: widget.initialValue,
      items: widget.items,
      required: true,
      strict: false,
      setter: (value) {
        widget.onSaved(value);
      },
      labelText: widget.label,
      itemsVisibleInDropdown: widget.itemsVisible,
      labelStyle: appFocusNode.hasFocus? AppTextStyle().getFocusedLabelStyle()
          : AppTextStyle().getInputLabelStyle(),
      textStyle: AppTextStyle().getInputTextStyle(),
    );
  }
}

class AppTextField extends StatelessWidget {
  final String initial;
  final Function validator;
  final Function onChanged;
  final String helperText;
  final TextInputType inputType;

  const AppTextField({
    Key? key,
    required this.initial,
    required this.validator,
    required this.onChanged,
    required this.helperText,
    required this.inputType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode appFocusNode = FocusNode();
    return TextFormField(
      initialValue: initial,
      onChanged: (value) => onChanged(value),
      validator: (value) => validator(value),
      style: AppTextStyle().getInputTextStyle(),
      decoration: InputDecoration(
        label: Text(helperText),
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black38,
                width: 1.5
            )
        ),
        labelStyle: appFocusNode.hasFocus? AppTextStyle().getFocusedLabelStyle()
            : AppTextStyle().getInputLabelStyle(),
      ),
      keyboardType: inputType,
    );
  }
}

class AppTextFieldSuffix extends StatelessWidget {
  final Function validator;
  final Function onChanged;
  final Widget suffix;
  final String label;
  final String helperText;
  final String initial;

  const AppTextFieldSuffix({
    Key? key,
    required this.onChanged,
    required this.suffix,
    required this.validator,
    required this.label,
    required this.helperText,
    required this.initial,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode appFocusNode = FocusNode();
    return TextFormField(
      initialValue: initial,
      onChanged: (value) => onChanged(value),
      validator: (value) => validator(value),
      style: AppTextStyle().getInputTextStyle(),
      decoration: InputDecoration(
          helperText: helperText,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black38,
                  width: 1.5
              )
          ),
          //icon: icon,
          label: Text(label),
          labelStyle: appFocusNode.hasFocus? AppTextStyle().getFocusedLabelStyle()
              : AppTextStyle().getInputLabelStyle(),
          suffix: suffix,
      ),
      keyboardType: TextInputType.number,
    );
  }
}

