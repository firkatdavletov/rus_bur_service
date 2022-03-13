import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rus_bur_service/styles/text_style.dart';

class PasswordField extends StatefulWidget {
  final Function onChanged;
  final Function validator;
  final String label;
  final String initial;

  const PasswordField({
    Key? key,
    required this.onChanged,
    required this.validator,
    required this.label,
    required this.initial
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
      initialValue: widget.initial,
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



