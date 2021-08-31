import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40.0),
      child: Image(
        image: AssetImage('assets/images/logo.png'),
        width: MediaQuery.of(context).size.width/1.25,
      ),
    );
  }
}