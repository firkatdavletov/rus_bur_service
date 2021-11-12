import 'dart:ffi';

import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RowWithButtons extends StatelessWidget {
  final String label;
  final VoidCallback addFunc;
  const RowWithButtons({
    Key? key,
    required this.label,
    required this.addFunc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        ElevatedButton(
            onPressed: null,
            child: Text('Add'),
            style: ButtonStyle(
            ),
        ),
        ElevatedButton(
          onPressed: null,
          child: Text('Delete'),
          style: ButtonStyle(
          ),
        )
      ]
    );
  }
}
