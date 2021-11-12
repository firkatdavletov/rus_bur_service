import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/models/operation.dart';
import 'package:rus_bur_service/models/part.dart';
import 'package:rus_bur_service/pages/cards_report_page.dart';
import 'package:rus_bur_service/pages/report_page3.dart';
import 'package:rus_bur_service/pages/report_page4.dart';
import 'package:rus_bur_service/pages/card_filling_page.dart';
import 'package:rus_bur_service/widgets/drawers/app_drawer.dart';
import 'package:rus_bur_service/widgets/list_views/expansion_list.dart';
import 'package:rus_bur_service/widgets/labeled_checkbox.dart';
import 'package:rus_bur_service/controller/diagnostic_cards_notifier.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';

import 'package:rus_bur_service/widgets/forms/text_form_field_report.dart';

import '../main.dart';

class DiagnosticCardsPage extends StatefulWidget {
  const DiagnosticCardsPage({Key? key}) : super(key: key);

  @override
  _DiagnosticCardsPageState createState() => _DiagnosticCardsPageState();
}

class _DiagnosticCardsPageState extends State<DiagnosticCardsPage> {
  final _inputTextStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black
  );

  int _unitId = 1;
  String _unitName = '';
  List<Part> listOfParts = [];
  List<List<Operation>> listsOfOperations = [];

  @override
  Widget build(BuildContext context) {
    listOfParts = context.read<DiagnosticCardsNotifier>().listOfParts;
    listsOfOperations = context.read<DiagnosticCardsNotifier>().listsOfOperations;

    return Scaffold(
      appBar: AppBar(
        title: Text('Диагностические карты'),
      ),
      drawer: ReportDrawer(),//_saveData(context),
      body: ListView.builder(
          itemCount: listOfParts.length,
          itemBuilder: (context, int i) {
            return Column(
              children: [
                ListTile(
                  title: Text('${listOfParts[i].name}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text('Удалить узел?'),
                                content: showAlertDialogDeletePart(i)
                            );
                          });
                      }
                  ),
                  tileColor: Colors.black26,
                ),
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listsOfOperations[i].length,
                    itemBuilder: (context, int j) {
                      return ListTile(
                        title: Text('${listsOfOperations[i][j].name}'),
                        subtitle: listsOfOperations[i][j].isRequired? Text('Обязательно для заполнения') : null,
                        trailing: listsOfOperations[i][j].isRequired?
                          null : IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Удалить выбранную операцию?'),
                                      content: showAlertDialogDeleteOperation(i, j),
                                    );
                                  });
                            },
                            icon: Icon(Icons.delete)),
                        onTap: () {
                          context.read<DiagnosticCardsNotifier>().changePartsList(listOfParts);
                          context.read<DiagnosticCardsNotifier>().changeOperationsList(listsOfOperations);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CardFillingPage(
                                      partIndex: i,
                                      operationIndex: j,
                                      operationId: listsOfOperations[i][j].id,
                                  )
                              )
                          );
                        },
                      );
                    }
                ),
              ],
            );
          }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text('Нажмите на выбранный узел:'),
                    content: showAlertDialogAddParts()
                );
              });
        },
        icon: Icon(Icons.add),
        label: Text('Добавить'),
        tooltip: 'Создание новой диагностической карты',
      ),
    );
  }

  Widget showAlertDialogAddParts() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
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
                          bool _ok = true;
                          for (int k = 0; k < listOfParts.length; k++) {
                            listOfParts[k].id == snapshot.data[i].id? _ok = false : null;
                          }
                          if (_ok) {
                            listOfParts.add(snapshot.data[i]);
                            context.read<DiagnosticCardsNotifier>().changePartsList(listOfParts);
                            _addOperationList(snapshot.data[i].id);
                            context.read<DiagnosticCardsNotifier>().changeOperationsList(listsOfOperations);
                            Navigator.pop(context, 'Добавлено');
                          } else {
                            _showSnack('Узел уже добавлен');
                          }
                        });

                      },
                    );
                  }
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error'),);
            } else {
              return Center(child: Text('Wait'),);
            }
          }

      ),
    );
  }

  Widget showAlertDialogDeletePart(int i) {
    return Container(
      // height: 300.0, // Change as per your requirement
      // width: 300.0, // Change as per your requirement
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _deletePart(i);
                    context.read<DiagnosticCardsNotifier>().changePartsList(listOfParts);
                    _deleteOperations(i);
                    context.read<DiagnosticCardsNotifier>().changeOperationsList(listsOfOperations);
                  });
                  Navigator.pop(context, 'Удалено');
                },
                child: Text('Удалить')),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Отменено');
                },
                child: Text('Отмена')),
          ),
        ],
      ),
    );
  }

  Widget showAlertDialogDeleteOperation(int i, int j) {
    return Container(
      // height: 300.0, // Change as per your requirement
      // width: 300.0, // Change as per your requirement
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _deleteOperation(i, j);
                    context.read<DiagnosticCardsNotifier>().changeOperationsList(listsOfOperations);
                  });
                  Navigator.pop(context, 'Удалено');
                },
                child: Text('Удалить')),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'Отменено');
                },
                child: Text('Отмена')),
          ),
        ],
      ),
    );
  }

  _showSnack (String text) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(milliseconds: 500),
      )
  );

  _getParts() {
    return db.getParts();
  }

  _getOperations(int id) {
    return db.getOperations('part_id', id);
  }

  _selectUnit(bool value, int id) {
    db.upgradeUnitSelect(value, id);
  }

  _selectAllCardsForUnit(bool value, int id) {
    db.upgradeCardSelectByUnit(value, id);
  }

  _addOperationList(int id) {
    Future<List<Operation>> ops = _getOperations(id);
    ops.then((value) {
      listsOfOperations.add(value);
    });
  }

  _deleteOperation(int i, int j) {
    listsOfOperations[i].removeAt(j);
  }

  _deletePart(int i) {
    listOfParts.removeAt(i);
  }

  _deleteOperations(int i) {
    listsOfOperations.removeAt(i);
  }
}

