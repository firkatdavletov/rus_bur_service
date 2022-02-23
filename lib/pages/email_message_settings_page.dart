import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/settings_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';
import 'package:rus_bur_service/widgets/appbar/app_bar.dart';
import 'package:rus_bur_service/widgets/drawers/app_drawer.dart';
import '../controller/user_notifier.dart';
import '../widgets/forms/app_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailMessageSettingsPage extends StatelessWidget {
  const EmailMessageSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _formKey_1 = GlobalKey<FormState>();
    final _formKey_2 = GlobalKey<FormState>();

    String _controller = '';

    return Scaffold(
      appBar: myAppBar('Настройки сообщения'),
      drawer: AppDrawer(user: context.watch<UserNotifier>().user),
      body: FutureBuilder(
          future: _getPrefs(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              List<String> emails = snapshot.data.getStringList('recipients_email');
              return Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Отправка отчета'),
                    SizedBox(height: 20,),
                    Form(
                      key: _formKey_1,
                      child: AppTextFormFieldWithInitWithoutIcon(
                          onSaved: (value) {
                            snapshot.data.setString('source_email', value);
                          },
                          validator: _validate,
                          initialValue: snapshot.data.getString('source_email'),
                          helperText: ''
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey_1.currentState!.validate()) {
                            _formKey_1.currentState!.save();
                          }
                        },
                        child: Text('Сохранить')
                    ),
                    SizedBox(height: 20,),
                    Divider(),
                    SizedBox(height: 20,),
                    Text('Получатели отчета'),
                    SizedBox(height: 20,),
                    Form(
                      key: _formKey_2,
                      child: AppTextFormFieldWithoutIcon(
                          onChanged: (value) {
                            _controller = value;
                          },
                          validator: _validate,
                          label: '',
                          helperText: ''
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Добавить'),
                      onPressed: () {
                        if (_formKey_2.currentState!.validate()) {
                          emails.add(_controller);
                          snapshot.data.setStringList('recipients_email', emails);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmailMessageSettingsPage()
                              )
                          );
                        }
                      },
                    ),
                    Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, int i) {
                            return ListTile(
                              title: Text(emails[i],),
                              leading: Text('${i+1}'),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  emails.removeAt(i);
                                  snapshot.data.setStringList('recipients_email', emails);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EmailMessageSettingsPage()
                                      )
                                  );
                                },
                              ),
                            );
                          },
                          itemCount: emails.length
                        )
                    ),
                    Divider(),
                    SizedBox(height: 20,),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsPage()
                              )
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_back_ios_outlined),
                            SizedBox(width: 10,),
                            Text('Назад')
                          ],
                        )
                    )
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return ErrorPage();
            } else {
              return WaitingPage();
            }
          }
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


