import 'package:flutter/material.dart';
import 'package:rus_bur_service/styles/text_style.dart';

class AppOutLinedButton extends StatelessWidget {

  final Function submit;
  final String text;

  const AppOutLinedButton({
    Key? key,
    required this.submit,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        submit();
      },
      child: Text(text, style: AppTextStyle().getButtonTextStyle(),),
    );
  }
}
