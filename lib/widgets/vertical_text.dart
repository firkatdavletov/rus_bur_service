import 'package:flutter/material.dart';
import 'package:rus_bur_service/styles/text_style.dart';

class VerticalText extends StatelessWidget {
  final String text;
  const VerticalText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: -1,
        child: Text(
          text,
          style: AppTextStyle().getVerticalTextStyle(),
        ));
  }
}
