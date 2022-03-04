import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/pages/home_page.dart';
import 'package:rus_bur_service/pages/machine_info_page.dart';
import 'package:rus_bur_service/pages/report_main_page.dart';
import '../../main.dart';
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

  @override
  Widget build(BuildContext context) {

    bool _enable = true;
    double _width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Form(
              key: _formKey_1,
              child: ListView(
                children: [
                  Container(height: 20),
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
                  Divider(),
                  Container(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInitWithoutIcon(
                      initialValue: context.watch<ReportNotifier>().date,
                      onSaved: (value) {
                        context.read<ReportNotifier>().changeDate(value);
                      },
                      validator: _validate,
                      helperText: 'Дата (ММ/ДД/ГГГГ)',
                    ),
                  ),
                  Divider(),
                  Container(height: 20),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                    child: AppTextFormFieldWithInitWithoutIcon(
                      initialValue: context.watch<ReportNotifier>().place,
                      onSaved: (value) {
                        context.read<ReportNotifier>().changePlace(value);
                      },
                      validator: _validate,
                      helperText: 'Место проведения осмотра',
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 5.0, right: 10.0, left: 10.0, top: 0.0),
                      child: ElevatedButton(
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.keyboard_arrow_up),
                            SizedBox(width: 10.0,),
                            Text('Вставить координаты')
                          ],
                        ),
                      )
                  ),
                  Divider(),
                  Container(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                    child: AppTextFormFieldWithInitWithoutIcon(
                      initialValue: context.watch<ReportNotifier>().customerName,
                      onSaved: (value) {
                        context.read<ReportNotifier>().changeCustomerName(value);
                      },
                      validator: _validate,
                      helperText: 'Контактное лицо заказчика',
                    ),
                  ),
                  Divider(),
                  Container(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInitWithoutIcon(
                      onSaved: (value) {
                        context.read<ReportNotifier>().changeCustomerPhone(value);
                      },
                      validator: _validateMobile,
                      initialValue: context.watch<ReportNotifier>().customerPhone,
                      helperText: 'Номер телефона заказчика',
                    ),
                  ),
                  Divider(),
                  Container(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: AppTextFormFieldWithInitWithoutIcon(
                      onSaved: (value) {
                        context.read<ReportNotifier>().changeCustomerEmail(value);
                      },
                      validator: _validate,
                      initialValue: context.watch<ReportNotifier>().customerEmail,
                      helperText: 'Email',
                    ),
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
              child: ElevatedButton (
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text('Сохранить отчёт?', textAlign: TextAlign.center,),
                          actions: [
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey_1.currentState!.validate() && _enable) {
                                    _formKey_1.currentState!.save();
                                    if (Provider.of<ReportNotifier>(context, listen: false).isNewReport) {
                                      await db.writeReport(context);
                                    } else {
                                      await db.upgradeReport(context);
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
              child: ElevatedButton (
                  onPressed: () async {
                    if (_formKey_1.currentState!.validate() && _enable) {
                      _formKey_1.currentState!.save();
                      if (Provider.of<ReportNotifier>(context, listen: false).isNewReport) {
                        await db.writeReport(context);
                      } else {
                        await db.upgradeReport(context);
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
                  ),
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
