import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final List<String> users = <String>[
    'Sasha',
    'Masha',
    'Kirill'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users page'
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(18.0),
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              color: Colors.white60,
              child: Center(
                child: Text('User name: ${users[index]}'),
              ),
            );
          },
      ),
    );
  }
}
