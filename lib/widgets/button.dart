import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const RoundedButton({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    this.textColor = Colors.white,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle buttonTextStyle = TextStyle(
      color: textColor,
      fontSize: 20,
    );
    final ButtonStyle RoundedButtonStyle = ElevatedButton.styleFrom(
        textStyle: buttonTextStyle,
        padding: EdgeInsets.symmetric(vertical: 10),
        primary: buttonColor
    );
    return ElevatedButton(
        style: RoundedButtonStyle,
        onPressed: onPressed,
        child: Text(buttonText)
    );
  }
}
