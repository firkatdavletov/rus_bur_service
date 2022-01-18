import 'package:flutter/material.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/settings_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';
import '../widgets/forms/app_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailMessageSettings extends StatelessWidget {
  const EmailMessageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _formKey_1 = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(' Настройки сообщения'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: _getPrefs(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Form(
                        key: _formKey_1,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                              child: AppTextFormFieldWithInit(
                                initialValue: snapshot.data.getString('recipients'),
                                onSaved: (value) {
                                  snapshot.data.setString('recipients', value);
                                },
                                validator: _validate,
                                icon: Icon(Icons.arrow_right, color: Colors.black26,),
                                label: 'Email получателя',
                                helperText: '',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                              child: AppTextFormFieldWithInit(
                                initialValue: snapshot.data.getString('subject'),
                                onSaved: (value) {
                                  snapshot.data.setString('subject', value);
                                },
                                validator: _validate,
                                icon: Icon(Icons.arrow_right, color: Colors.black26,),
                                label: 'Тема сообщения',
                                helperText: '',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                              child: AppTextFormFieldWithInit(
                                initialValue: snapshot.data.getString('text'),
                                onSaved: (value) {
                                  snapshot.data.setString('text', value);
                                },
                                validator: _validate,
                                icon: Icon(Icons.arrow_right, color: Colors.black26,),
                                label: 'Текст сообщения',
                                helperText: '',
                              ),
                            ),
                          ],
                        ));
                  } else if (snapshot.hasError) {
                    return ErrorPage();
                  } else {
                    return WaitingPage();
                  }
                }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: OutlinedButton (
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()
                            )
                        );
                      },
                      child: Text('Назад')
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: OutlinedButton (
                      onPressed: () {
                        if (_formKey_1.currentState!.validate()) {
                          _formKey_1.currentState!.save();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()
                              )
                          );
                        }
                      },
                      child: Text('Сохранить')
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  _validate(String value) {
    if (value.isEmpty) {
      return 'Пожалуйста, заполните поле';
    }
  }
}
