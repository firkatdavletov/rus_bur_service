import 'package:flutter/material.dart';

class ListRowReport extends StatelessWidget {
  final String name;
  final String date;
  final String company;
  final String machine;

  const ListRowReport({
    Key? key,
    required this.name,
    required this.date,
    required this.company,
    required this.machine
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _nameTextStyle = TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.black54
    );
    TextStyle _dateTextStyle = TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        color: Colors.black26
    );
    TextStyle _companyTextStyle = TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.black54
    );
    TextStyle _machineTextStyle = TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        color: Colors.black26
    );
    return Row(
      children: [
        Expanded(
            child: Column(
              children: [
                Text(name, style: _nameTextStyle),
                Text(date, style: _dateTextStyle),
              ],
            ),
          flex: 2,
        ),
        Expanded(
            child: Column(
              children: [
                Text(company, style: _companyTextStyle),
                Text(machine, style: _machineTextStyle)
              ],
            ),
          flex: 3,
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert)
        )
      ],
    );
  }
}
