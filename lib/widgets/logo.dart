import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double logoSize;

  const Logo({Key? key, required this.logoSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: AssetImage('assets/images/logo.png'),
        width: logoSize,
      ),
    );
  }
}
