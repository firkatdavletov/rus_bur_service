import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rus_bur_service/pages/home_page.dart';

import '../main.dart';
import '../model.dart';

class CreateReport extends StatefulWidget {
  const CreateReport({Key? key}) : super(key: key);

  @override
  _CreateReportState createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  TextEditingController _companyName = TextEditingController();
  TextEditingController _place = TextEditingController();
  TextEditingController _customerFirstName = TextEditingController();
  TextEditingController _customerLastName = TextEditingController();
  TextEditingController _customerMiddleName = TextEditingController();
  TextEditingController _customerPhone = TextEditingController();
  TextEditingController _customerEmail = TextEditingController();
  TextEditingController _machineModel = TextEditingController();
  TextEditingController _machineSN = TextEditingController();
  TextEditingController _machineYear = TextEditingController();
  TextEditingController _engineModel = TextEditingController();
  TextEditingController _engineSN = TextEditingController();
  TextEditingController _engineOperatingTime = TextEditingController();
  TextEditingController _note = TextEditingController();

  late String result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Создание отчёта'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _textBuilder('Название юридического лица:'),
            _textFormFieldBuild(_companyName, ''),
            _textBuilder('Место проведения работ:'),
            _textFormFieldBuild(_place, ''),
            _textBuilder('Контактное лицо заказчика:'),
            _textFormFieldBuild(_customerFirstName, 'Имя'),
            _textFormFieldBuild(_customerLastName, 'Фамилия'),
            _textFormFieldBuild(_customerMiddleName, 'Отчество'),
            _textFormFieldBuild(_customerPhone, 'Номер телефона'),
            _textFormFieldBuild(_customerEmail, 'Электронная почта'),
            _textBuilder('Данные машины'),
            _textFormFieldBuild(_machineModel, 'Модель'),
            _textFormFieldBuild(_machineSN, 'Серийный номер'),
            _textFormFieldBuild(_machineYear, 'Год выпуска'),
            _textBuilder('Данные двигателя'),
            _textFormFieldBuild(_engineModel, 'Модель'),
            _textFormFieldBuild(_engineSN, 'Серийный номер'),
            _textFormFieldBuild(_engineOperatingTime, 'Наработка'),
            _textBuilder('Примечание'),
            _textFormFieldBuild(_note, ''),
            Container(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: ElevatedButton(
                  style: _buttonStyle,
                  onPressed: () {
                    _saveReport();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage()
                        )
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('СОХРАНИТЬ'),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
  _textFormFieldBuild(TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText
      ),
    );
  }
  _textBuilder(String text) {
    return Text(
      text,
      style: TextStyle(
      fontSize: 18.0,
      ),
    );
  }
  final _buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      padding: EdgeInsets.symmetric(vertical: 10)
  );

  _saveReport() async {
    Report report = Report(
        id: 2,
        userId: 1,
        customerId: 1,
        machineId: 1,
        engineId: 1,
        name: 'testname1',
        date: 'tastdate1',
        place: _place.text,
        note: _note.text
    );

    await db.insertReport(report);
  }

  _saveCustomer() async {
    Customer customer = Customer(
        id: 1,
        firstName: _customerFirstName.text,
        lastName: _customerLastName.text,
        middleName: _customerMiddleName.text,
        phone: _customerPhone.text,
        email: _customerEmail.text
    );

    await db.insertCustomer(customer);
  }

  _saveMachine() async {
    Machine machine = Machine(
        id: 1,
        model: _machineModel.text,
        serNumb: _machineSN.text,
        year: _machineYear.text
    );

    await db.insertMachine(machine);
  }

  _saveEngine() async {
    Engine engine = Engine(
        id: 1,
        model: _engineModel.text,
        serNumb: _engineSN.text,
        operatingTime: _engineOperatingTime.text
    );

    await db.insertEngine(engine);
  }
}
