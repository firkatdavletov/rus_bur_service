import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Input {

}

class TextFieldWidget extends StatelessWidget {
  final IconData icon;
  final String? hint;
  final bool isObscure;
  final TextInputType? inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final double fontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        controller: textController,
        style: TextStyle(
          fontSize: fontSize,
        ),
        obscureText: isObscure,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            size: iconSize,
            color: Colors.white70,),
          hintText: hint,
        ),
      )
    );
  }

  const TextFieldWidget({
    Key? key,
    required this.icon,
    required this.textController,
    required this.hint,
    this.inputType = TextInputType.name,
    required this.isObscure,
    required this.fontSize,
    required this.iconSize,
    this.padding = const EdgeInsets.only(top: 15, bottom: 15),
    this.hintColor = Colors.black54,
    this.iconColor = Colors.white70,
  }) : super(key: key);
}
