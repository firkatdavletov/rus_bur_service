import 'package:flutter/material.dart';
import 'package:rus_bur_service/styles/image_style.dart';

class Logo extends StatelessWidget {

  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: AssetImage('assets/images/logo.png'),
        width: AppImageStyle().getLogoSize(),
      ),
    );
  }
}
