import 'package:flutter/material.dart';

final _labelTextStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.black
);

final _inputTextStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.black
);

final double _top = 20.0;
final double _bottom = 20.0;
final double _left = 20.0;
final double _right = 20.0;

class InputReportCtrl extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final int maxLines;
  const InputReportCtrl({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.maxLines
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
        padding: EdgeInsets.only(right: _right, left: _left, top: _top, bottom: _bottom),
        child: TextFormField(
          style: _inputTextStyle,
          maxLines: maxLines,
          controller: controller,
          decoration: InputDecoration(
              labelStyle: _labelTextStyle,
              labelText: labelText,
              hintText: hintText,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0))
              )
          ),
        )
    );
  }
}

class InputReportWithDropMenu extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;

  static const menuItems = <String>[
    'м/ч',
    'уд/ч',
    'пог.м'
  ];

  const InputReportWithDropMenu({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _btnSelectedVal = 'м/ч';
    List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
        .map(
            (String value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
            ),
    ).toList();

    return Padding(
        padding: EdgeInsets.only(right: _right, left: _left, top: _top, bottom: _bottom),
        child: TextFormField(
          style: _inputTextStyle,
          controller: controller,
          decoration: InputDecoration(
              labelStyle: _labelTextStyle,
              labelText: labelText,
              hintText: hintText,
              suffix: DropdownButton<String>(
                value: _btnSelectedVal,
                items: _dropDownMenuItems,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0))
              )
          ),
        )
    );
  }
}

class InputReportIntl extends StatelessWidget {
  final String initialValue;
  final String labelText;
  const InputReportIntl({
    Key? key,
    required this.initialValue,
    required this.labelText, maxLines
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: _right, left: _left, top: _top, bottom: _bottom),
        child: TextFormField(
          style: _inputTextStyle,
          initialValue: initialValue,
          readOnly: true,
          decoration: InputDecoration(
              labelStyle: _labelTextStyle,
              labelText: labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.0))
              )
          ),
        )
    );
  }
}








