import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/controller/user_notifier.dart';
import 'package:rus_bur_service/pages/home_page.dart';
import 'package:rus_bur_service/pages/machine_info_page.dart';
import 'package:rus_bur_service/pages/report_main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../../models/status.dart';
import 'app_text_form_field.dart';

class CreateReportForm extends StatefulWidget {
  const CreateReportForm({Key? key}) : super(key: key);

  @override
  _CreateReportFormState createState() => _CreateReportFormState();
}

class _CreateReportFormState extends State<CreateReportForm> {
  final _formKey_1 = GlobalKey<FormState>();

  _validate(String value) {
      if (value.isEmpty) {
        return 'Пожалуйста, заполните поле';
      }
  }

  _validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
  }

  _getReportsCount(int userId) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    int? mainCounter = (prefs.getInt('main_counter') ?? 0) + 1;
    await prefs.setInt('main_counter', mainCounter);

    int? separateCounter = (prefs.getInt('counter_$userId') ?? 0) + 1;
    await prefs.setInt('counter_$userId', separateCounter);

    return {
      'mainCount': mainCounter,
      'userCount' : separateCounter
    };
  }

  @override
  Widget build(BuildContext context) {

    bool _enable = true;
    double _width = MediaQuery.of(context).size.width;

    _writeReportIdAndName() async {
      var _map = _getReportsCount(Provider.of<UserNotifier>(context, listen: false).user.userId);
      _map.then((map) {
        context.read<ReportNotifier>().changeReportId(map['mainCount']);
        String _name = '${Provider.of<UserNotifier>(context, listen: false).user.userId}-${map['userCount']}';
        context.read<ReportNotifier>().changeName(_name);
        context.read<ReportNotifier>().changeUserId(
            Provider.of<UserNotifier>(context, listen: false).user.userId);
        db.insertReport_2(context);
        _enable = false;
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Form(
              key: _formKey_1,
              child: ListView(
                children: [
                  Container(
                    height: 20,
                  ),
                  ExpansionTile(
                      title: Text('Заказчик'),
                      maintainState: true,
                      leading: context.watch<ReportNotifier>().company.isEmpty
                          ? Icon(Icons.error_outline)
                          : Icon(Icons.check),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          child: AppTextFormFieldWithInitWithoutIcon(
                            initialValue: context.watch<ReportNotifier>().company,
                            onSaved: (value) {
                              context.read<ReportNotifier>().changeCompany(value);
                            },
                            validator: _validate,
                            helperText: 'Наименование юридического лица',
                          ),
                        ),
                      ],
                  ),
                  ExpansionTile(
                    title: Text('Дата осмотра'),
                    maintainState: true,
                    leading: context.watch<ReportNotifier>().date.isEmpty
                        ? Icon(Icons.error_outline)
                        : Icon(Icons.check),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: AppTextFormFieldWithInitWithoutIcon(
                          initialValue: context.watch<ReportNotifier>().date,
                          onSaved: (value) {
                            context.read<ReportNotifier>().changeDate(value);
                          },
                          validator: _validate,
                          helperText: 'ДД/ММ/ГГГГ',
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Место проведения осмотра'),
                    maintainState: true,
                    leading: context.watch<ReportNotifier>().place.isEmpty
                        ? Icon(Icons.error_outline)
                        : Icon(Icons.check),
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                        child: AppTextFormFieldWithInitWithoutIcon(
                          initialValue: context.watch<ReportNotifier>().place,
                          onSaved: (value) {
                            context.read<ReportNotifier>().changePlace(value);
                          },
                          validator: _validate,
                          helperText: '',
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 20.0, right: 10.0, left: 10.0, top: 0.0),
                          child: OutlinedButton(
                            onPressed: () async {
                              _formKey_1.currentState!.save();
                              Position _position = await determinePosition();
                              setState(() {
                                String latitude = '${_position.latitude}';
                                String longitude = '${_position.longitude}';
                                String _positionTxt = '$latitude, $longitude;';
                                context.read<ReportNotifier>().changePlace(_positionTxt);
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReportMainPage()
                                  )
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.keyboard_arrow_up),
                                SizedBox(width: 10.0,),
                                Text('Вставить координаты')
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Контактное лицо заказчика'),
                    maintainState: true,
                    leading: context.watch<ReportNotifier>().customerName.isEmpty
                        ? Icon(Icons.error_outline)
                        : Icon(Icons.check),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                        child: AppTextFormFieldWithInitWithoutIcon(
                          initialValue: context.watch<ReportNotifier>().customerName,
                          onSaved: (value) {
                            context.read<ReportNotifier>().changeCustomerName(value);
                          },
                          validator: _validate,
                          helperText: 'ФИО',
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Номер телефона'),
                    maintainState: true,
                    leading: context.watch<ReportNotifier>().customerPhone.isEmpty
                        ? Icon(Icons.error_outline)
                        : Icon(Icons.check),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: AppTextFormFieldWithInitWithoutIcon(
                          onSaved: (value) {
                            context.read<ReportNotifier>().changeCustomerPhone(value);
                          },
                          validator: _validateMobile,
                          initialValue: context.watch<ReportNotifier>().customerPhone,
                          helperText: '',
                        ),
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Email'),
                    maintainState: true,
                    leading: context.watch<ReportNotifier>().customerEmail.isEmpty
                        ? Icon(Icons.error_outline)
                        : Icon(Icons.check),
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: AppTextFormFieldWithInitWithoutIcon(
                          onSaved: (value) {
                            context.read<ReportNotifier>().changeCustomerEmail(value);
                          },
                          validator: _validate,
                          initialValue: context.watch<ReportNotifier>().customerEmail,
                          helperText: '',
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: OutlinedButton (
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text('Сохранить отчёт?', textAlign: TextAlign.center,),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey_1.currentState!.validate() && _enable) {
                                    _formKey_1.currentState!.save();
                                    if (Provider.of<ReportNotifier>(context, listen: false).isNewReport) {
                                      _writeReportIdAndName();
                                    } else {
                                      db.upgradeReport_2(context);
                                      _enable = false;
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()
                                        )
                                    );
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: Text('Да')
                            ),
                            OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()
                                      )
                                  );
                                },
                                child: Text('Нет')
                            )
                          ],
                          actionsAlignment: MainAxisAlignment.spaceAround,
                        )
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.home),
                      Container(width: 5,),
                      _width > 400
                          ? Text('Главная страница')
                          : Text('')
                    ],
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: OutlinedButton (
                  onPressed: () {
                    if (_formKey_1.currentState!.validate() && _enable) {
                      _formKey_1.currentState!.save();
                      if (Provider.of<ReportNotifier>(context, listen: false).isNewReport) {
                        _writeReportIdAndName();
                      } else {
                        db.upgradeReport_2(context);
                        _enable = false;
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MachineInfoPage()
                          )
                      );
                    }
                  },
                  child: Row(
                    children: [
                      _width > 400
                          ? Text('Данные машины')
                          : Text(''),
                      Container(width: 5,),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  )
              ),
            )
          ],
        )
      ],
    );
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
