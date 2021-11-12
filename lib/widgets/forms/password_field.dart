import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rus_bur_service/styles/text_style.dart';

class PasswordField extends StatefulWidget {
  final Function onChanged;
  final Function validator;
  final Icon icon;
  final String label;

  const PasswordField({
    Key? key,
    required this.onChanged,
    required this.validator,
    required this.icon,
    required this.label
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  FocusNode appFocusNode = FocusNode();
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => widget.onChanged(value),
      validator: (value) => widget.validator(value),
      style: AppTextStyle().getInputTextStyle(),
      obscureText: _obscure,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black38,
                  width: 1.5
              )
          ),
          icon: widget.icon,
          label: Text(widget.label),
          labelStyle: appFocusNode.hasFocus? AppTextStyle().getInputLabelStyle()
            : AppTextStyle().getFocusedLabelStyle(),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
            child: Icon(
              _obscure? Icons.visibility : Icons.visibility_off,
              color: Colors.black54,
            ),
        )
      ),
    );
  }
}

class PasswordFieldWithInit extends StatefulWidget {
  final Function onSaved;
  final Function validator;
  final Icon icon;
  final String label;
  final String initialValue;
  final bool enabled;

  const PasswordFieldWithInit({
    Key? key,
    required this.onSaved,
    required this.validator,
    required this.icon,
    required this.label,
    required this.initialValue,
    required this.enabled
  }) : super(key: key);

  @override
  _PasswordFieldWithInitState createState() => _PasswordFieldWithInitState();
}

class _PasswordFieldWithInitState extends State<PasswordFieldWithInit> {
  FocusNode appFocusNode = FocusNode();
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      initialValue: widget.initialValue,
      onSaved: (value) => widget.onSaved(value),
      validator: (value) => widget.validator(value),
      style: AppTextStyle().getInputTextStyle(),
      obscureText: _obscure,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black38,
                  width: 1.5
              )
          ),
          icon: widget.icon,
          label: Text(widget.label),
          labelStyle: appFocusNode.hasFocus? AppTextStyle().getInputLabelStyle()
              : AppTextStyle().getFocusedLabelStyle(),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
            child: Icon(
              _obscure? Icons.visibility : Icons.visibility_off,
              color: Colors.black54,
            ),
          )
      ),
    );
  }
}


