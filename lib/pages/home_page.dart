import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../model.dart';
import 'create_report.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);
  final String user;
  @override
  _HomePageState createState() => _HomePageState();
}

_getListOfDogs() async {
  List<Dog> dogs = await db.dogs();
  //final List<String> dogNames = dogs.map((dog) => dog.id.toString()).toList();
  return dogs;
}

_getListOfReports() async {
  List<Report> reports = await db.reports();
  return reports;
}

class _HomePageState extends State<HomePage> {
  String get user => this.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Отчёты'),
        actions: [

        ],
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){

            },
        ),
      ),
      body: FutureBuilder(
        future: _getListOfReports(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Text(snapshot.data[index].toString());
                });
            } else if (snapshot.hasError) {
              return Text('Error');
            } else {
              return Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              );
            }
          },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateReport()
              )
            );
          },
          child: Icon(Icons.add))
    );
  }
}
