import 'package:flutter/material.dart';
import 'package:rus_bur_service/styles/text_style.dart';
import 'package:dropdownfield2/dropdownfield2.dart';

class AppTextFormField extends StatelessWidget {
  final Function onChanged;
  final Function validator;
  final Icon icon;
  final String label;
  final String helperText;
  const AppTextFormField({
    Key? key,
    required this.onChanged,
    required this.validator,
    required this.icon,
    required this.label,
    required this.helperText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode appFocusNode = FocusNode();
    return TextFormField(
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
        icon: icon,
        label: Text(label),
        labelStyle: appFocusNode.hasFocus? AppTextStyle().getFocusedLabelStyle()
            : AppTextStyle().getInputLabelStyle(),
      ),
    );
  }
}

class AppTextFormFieldWithoutIcon extends StatelessWidget {
  final Function onChanged;
  final Function validator;
  final String label;
  final String helperText;
  const AppTextFormFieldWithoutIcon({
    Key? key,
    required this.onChanged,
    required this.validator,
    required this.label,
    required this.helperText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode appFocusNode = FocusNode();
    return TextFormField(
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
        label: Text(label),
        labelStyle: appFocusNode.hasFocus? AppTextStyle().getFocusedLabelStyle()
            : AppTextStyle().getInputLabelStyle(),
      ),
    );
  }
}

class AppTextFormFieldWithInit extends StatelessWidget {
  final Function onSaved;
  final Function validator;
  final Icon icon;
  final String label;
  final String initialValue;
  final String helperText;
  const AppTextFormFieldWithInit({
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

class AppTextFormFieldWithInitSuffix extends StatelessWidget {
  final Function onSaved;
  final Function validator;
  final Icon icon;
  final String label;
  final String initialValue;
  final String helperText;
  final String suffixText;
  const AppTextFormFieldWithInitSuffix({
    Key? key,
    required this.onSaved,
    required this.validator,
    required this.icon,
    required this.label,
    required this.initialValue,
    required this.helperText,
    required this.suffixText
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
        suffixText: suffixText
      ),
    );
  }
}

class AppDropDownFormField extends StatefulWidget {
  final Function onSaved;
  final Icon icon;
  final String label;
  final String initialValue;
  final List<String> items;
  final int itemsVisible;
  const AppDropDownFormField({
    Key? key,
    required this.onSaved,
    required this.icon,
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
      icon: widget.icon,
      labelText: widget.label,
      itemsVisibleInDropdown: widget.itemsVisible,
      labelStyle: appFocusNode.hasFocus? AppTextStyle().getFocusedLabelStyle()
          : AppTextStyle().getInputLabelStyle(),
      textStyle: AppTextStyle().getInputTextStyle(),
    );
  }
}


class AppTextFormFieldWithInitMaxLines extends StatelessWidget {
  final Function onSaved;
  final Function validator;
  final Icon icon;
  final String label;
  final String initialValue;
  final String helperText;
  final int maxLines;
  const AppTextFormFieldWithInitMaxLines({
    Key? key,
    required this.onSaved,
    required this.validator,
    required this.icon,
    required this.label,
    required this.initialValue,
    required this.helperText,
    required this.maxLines
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode appFocusNode = FocusNode();
    return TextFormField(
      initialValue: initialValue,
      onSaved: (value) => onSaved(value),
      validator: (value) => validator(value),
      style: AppTextStyle().getInputTextStyle(),
      maxLines: maxLines,
      minLines: 1,
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