import 'package:flutter/material.dart';
import 'package:rus_bur_service/models/user.dart';

class UsersDataSource extends DataTableSource {
  final List<User> _users = [
    User(userId: 0, login: '1', firstName: 'firstName', lastName: 'lastName', middleName: 'middleName'),
    User(userId: 0, login: '2', firstName: 'firstName', lastName: 'lastName', middleName: 'middleName'),
    User(userId: 0, login: '3', firstName: 'firstName', lastName: 'lastName', middleName: 'middleName')
  ];


  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _users.length) return null;
    final User user = _users[index];
    return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(Text('${user.userId}')),
          DataCell(Text(user.firstName))
        ]
    );
    // TODO: implement getRow
    throw UnimplementedError();
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _users.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}