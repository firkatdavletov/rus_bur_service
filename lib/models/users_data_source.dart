import 'package:flutter/material.dart';
import 'package:rus_bur_service/models/user.dart';

class UsersDataSource extends DataTableSource {
  final List<User> users;

  UsersDataSource({
    required this.users
  });


  @override
  DataRow? getRow(int index) {
    // TODO: implement getRow
    throw UnimplementedError();
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => throw UnimplementedError();

  @override
  // TODO: implement rowCount
  int get rowCount => throw UnimplementedError();

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => throw UnimplementedError();
}