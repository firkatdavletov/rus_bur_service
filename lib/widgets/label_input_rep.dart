import 'package:flutter/material.dart';

class LabelInputReport extends StatelessWidget {
  final String label;
  const LabelInputReport({
    Key? key,
    required this.label
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _titleTextStyle = TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.black
    );
    return Padding(
      padding: EdgeInsets.only(left: 20.0, top: 20.0),
      child: Text(label, style: _titleTextStyle),
    );
  }
}
