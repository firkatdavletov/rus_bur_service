import 'package:flutter/material.dart';
import 'package:rus_bur_service/styles/text_style.dart';


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