import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:rus_bur_service/models/users_data_source.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final tableColumns = <DataColumn>[
    DataColumn(label: Text('ID')),
    DataColumn(label: Text('Name'))
  ];

  @override
  Widget build(BuildContext context) {
    _getUsersList() async {
      return <User>[
        User(login: 'a', firstName: 'b', lastName: 'c', middleName: 'd')
      ];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users page'
        ),
      ),
      body: FutureBuilder(
        future: _getUsersList(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
                child: PaginatedDataTable(
                  header: Text('List'),
                  columns: tableColumns,
                  source: UsersDataSource(users: [snapshot.data]),
                ),
            );
          } else if (snapshot.hasError) {
            return Text('Error');
          } else {
            return Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            );
          }
        },
      )
    );
  }
}

