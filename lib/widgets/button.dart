import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  final double fontSize;
  final double vertPadding;
  final double horPadding;

  const RoundedButton({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    this.textColor = Colors.white,
    required this.onPressed,
    required this.fontSize,
    required this.vertPadding,
    required this.horPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
        textStyle: TextStyle(
          fontSize: fontSize,
        ),
        padding: EdgeInsets.symmetric(
            vertical: vertPadding,
            horizontal: horPadding
        ),
        enableFeedback: true,
        primary: buttonColor,
    );
    return ElevatedButton(
        style: _buttonStyle,
        onPressed: onPressed,
        child: Text(buttonText)
    );
  }
}
