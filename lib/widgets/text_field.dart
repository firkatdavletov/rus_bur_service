import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData icon;
  final String? hint;
  final String? errorText;
  final bool isObscure;
  final bool isIcon;
  final TextInputType? inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;

  @override
  Widget build(BuildContext context) {
    final Radius radius = Radius.circular(15.0);
    return Padding(
      padding: padding,
      child: TextField(
        obscureText: isObscure,
        decoration: InputDecoration(
          icon: Icon(icon),
          hintText: hint,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white70,
                width: 10
              ),
            borderRadius: BorderRadius.all(radius),

          ),
        ),
      )
    );
  }

  const TextFieldWidget({
    Key? key,
    required this.icon,
    required this.errorText,
    required this.textController,
    required this.hint,
    this.inputType = TextInputType.name,
    required this.isObscure,
    this.isIcon = true,
    this.padding = const EdgeInsets.only(top: 15, bottom: 15),
    this.hintColor = Colors.black54,
    this.iconColor = Colors.white70,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
  }) : super(key: key);
}
