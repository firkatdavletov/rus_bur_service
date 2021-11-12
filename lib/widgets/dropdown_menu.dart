import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/machine_notifier.dart';

class MyDropdownMenu extends StatefulWidget {
  final List<String> list;
  final String dropdownValue;
  final ValueSetter<String> func;

  const MyDropdownMenu({
    Key? key,
    required this.list,
    required this.dropdownValue,
    required this.func
  }) : super(key: key);

  @override
  State<MyDropdownMenu> createState() => _MyDropdownMenuState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyDropdownMenuState extends State<MyDropdownMenu> {

  
  final _inputTextStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black
  );

  @override
  Widget build(BuildContext context) {
    String _dropdownValue = widget.dropdownValue;
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: DropdownButton<String>(
        value: _dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 16,
        style: _inputTextStyle,
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            widget.func(newValue!);
          });
        },
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    );
  }
}