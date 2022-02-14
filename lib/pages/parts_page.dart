import 'package:flutter/material.dart';
import 'package:rus_bur_service/main.dart';
import 'package:rus_bur_service/models/operation.dart';
import 'package:rus_bur_service/models/part.dart';


class PartsPage extends StatefulWidget {
  const PartsPage({Key? key}) : super(key: key);

  @override
  _PartsPageState createState() => _PartsPageState();
}

class _PartsPageState extends State<PartsPage> {

  final _inputTextStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black
  );

  int _partId = 1;
  int _operationId = 1;
  int _selectedPart = 0;
  int _selectedOperation = 0;
  bool _isRequired = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Диагностические операции'),
      ),
      //drawer: DrawerReport(saveData: () {  },),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text('Узлы:', style: _inputTextStyle,),
          ),
          Expanded(
              flex: 2,
              child: FutureBuilder(
                future: _getParts(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, int i) {
                          return ListTile(
                            title: Text('${snapshot.data[i].name}'),
                            onTap: () {
                              setState(() {
                                _partId = snapshot.data[i].id;
                                _selectedPart = i;
                              });
                            },
                            selected: _selectedPart == i,
                            selectedTileColor: Colors.black12,
                          );
                        }
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error((('));
                  } else {
                    return Center(child: Text('Wait...'));
                  }
                },
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        TextEditingController _ctrl = TextEditingController();
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Введите название нового узла'),
                            content: TextField(
                              controller: _ctrl,
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Отмена'),
                                child: const Text('Отмена'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    Part newPart = Part(
                                        id: 0,
                                        name: _ctrl.text,
                                    );
                                    _addPart(newPart);
                                  });
                                  Navigator.pop(context, 'Добавить');
                                },
                                child: const Text('Добавить', style: TextStyle(color: Colors.green),),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text('Добавить')
                  ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 10.0),
              //   child: ElevatedButton(
              //       onPressed: () {},
              //       child: Text('Edit')
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Удалить выбранный узел?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Отмена'),
                            child: const Text('Отмена'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _removePart(_partId);
                              });
                              Navigator.pop(context, 'Удалить');
                              },
                            child: const Text('Удалить', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      ),
                    ),
                    child: Text('Удалить')
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text('Операции:', style: _inputTextStyle,),
          ),
          Expanded(
              flex: 3,
              child: FutureBuilder(
                future: _getOperations(_partId),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, int i) {
                          return ListTile(
                            title: Text('${snapshot.data[i].name}'),
                            onTap: () {
                              setState(() {
                                _operationId = snapshot.data[i].id;
                                _selectedOperation = i;
                              });
                            },
                            selected: _selectedOperation == i,
                            selectedTileColor: Colors.black12,
                          );
                        }
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error((('));
                  } else {
                    return Center(child: Text('Wait...'),);
                  }
                },
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                    onPressed: () {
                      TextEditingController _ctrl = TextEditingController();
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Введите название новой карты'),
                          content: StatefulBuilder(
                            builder: (context, StateSetter setState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _ctrl,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Checkbox(
                                        value: _isRequired,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            _isRequired = newValue!;
                                          });
                                        },
                                      ),
                                      Text('Обязательная операция')
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Отмена'),
                              child: const Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  Operation newOperation = Operation(
                                      id: 0,
                                      name: _ctrl.text,
                                      partId: _partId,
                                      isRequired: _isRequired
                                  );
                                  _addOperation(newOperation);
                                });
                                Navigator.pop(context, 'Добавить');
                              },
                              child: const Text('Добавить', style: TextStyle(color: Colors.green),),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Добавить')
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 10.0),
              //   child: ElevatedButton(
              //       onPressed: () {},
              //       child: Text('Edit')
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Удалить выбранную карту?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Отмена'),
                            child: const Text('Отмена'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _removeOperation(_operationId);
                              });
                              Navigator.pop(context, 'Удалить');
                            },
                            child: const Text('Удалить', style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      ),
                    ),
                    child: Text('Удалить')
                ),
              )
            ],
          ),
        ],
      )
    );
  }

  _getParts() {
    return db.getParts();
  }

  _addPart(Part newPart) {
    db.insertPart(newPart);
  }

  _removePart(int partID) {
    db.deletePart(partID);
  }

  _getOperations(int id) {
    return db.getOperations('part_id', id);
  }
  
  _addOperation(Operation operation) {
    db.insertOperation(operation);
  }
  
  _removeOperation(int id) {
    db.deleteOperation(id);
  }
}


