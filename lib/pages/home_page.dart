import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../report.dart';

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

Dog _dog1 = Dog(id:1, name:'Kosmos', age:2);
Dog _dog2 = Dog(id:2, name:'Grut', age:4);
Dog _dog3 = Dog(id:3, name:'Hash', age:3);

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Отчёты'),
      ),
      body: FutureBuilder(
        future: _getListOfDogs(),
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
            db.insertDog(_dog1);
            db.insertDog(_dog2);
            db.insertDog(_dog3);
          },
          child: Icon(Icons.add),
      )
    );
  }
}
