import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/picture_notifier.dart';
import 'package:rus_bur_service/helpers/app_shared_preferance.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';
import 'package:rus_bur_service/widgets/forms/app_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PicturesSettingsForm extends StatefulWidget {
  const PicturesSettingsForm({Key? key}) : super(key: key);

  @override
  _PicturesSettingsFormState createState() => _PicturesSettingsFormState();
}

class _PicturesSettingsFormState extends State<PicturesSettingsForm> {
  _isDouble(String s) {
    if (s.isEmpty) {
      return 'Пожалуйста, заполните поле';
    }
    if (double.tryParse(s) == null) {
      return 'Введите десятичное число';
    }
  }
  _isInteger(String s) {
    if (s.isEmpty) {
      return 'Пожалуйста, заполните поле';
    }
    int? n = int.tryParse(s);
    if (n == null || n < 1 || n > 100) {
      return 'Введите десятичное число от 1 до 100';
    }
  }

  _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FutureBuilder(
              future: _getPrefs(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                          child: AppTextFieldSaved(
                              onSaved: (value) {
                                snapshot.data.setDouble(
                                  'maxPictureHeight',
                                  double.parse(value)
                                );
                              },
                              validator: _isDouble,
                              icon: Icon(Icons.height),
                              label: 'Максимальная высота',
                              initialValue: snapshot.data.getDouble('maxPictureHeight')
                                  .toString(),
                              helperText: 'Введите число'
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                          child: AppTextFieldSaved(
                              onSaved: (value) {
                                snapshot.data.setDouble(
                                    'maxPictureWidth',
                                    double.parse(value)
                                );
                              },
                              validator: _isDouble,
                              icon: Icon(Icons.arrow_right_alt_sharp),
                              label: 'Максимальная ширина',
                              initialValue: snapshot.data.getDouble('maxPictureWidth')
                                  .toString(),
                              helperText: 'Введите число'
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                          child: AppTextFieldSaved(
                              onSaved: (value) {
                                snapshot.data.setInt(
                                    'pictureQuality',
                                    int.parse(value)
                                );
                              },
                              validator: _isInteger,
                              icon: Icon(Icons.high_quality_outlined),
                              label: 'Качество',
                              initialValue: snapshot.data.getInt('pictureQuality')
                                  .toString(),
                              helperText: 'Введите число от 1 до 100'
                          )
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return ErrorPage();
                } else {
                  return WaitingPage();
                }
              },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: ElevatedButton(
              child: Text('Сохранить'),
              onPressed: () {
                setState(() {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
