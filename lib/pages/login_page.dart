import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rus_bur_service/widgets/text_field.dart';
import 'package:rus_bur_service/widgets/logo.dart';
import 'package:rus_bur_service/widgets/button.dart';

import 'package:rus_bur_service/auth.dart';
import 'package:rus_bur_service/widgets/vertical_text.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _loginInput = TextEditingController();
  final TextEditingController _passwordInput = TextEditingController();

  final Icon loginIcon = Icon(Icons.person);
  final Icon passwordIcon = Icon(Icons.password);

  final String loginLabelText = 'Введите имя пользователя';
  final String passwordLabelText = 'Введите пароль';
  final String loginButtonText = 'Войти';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
        body: Container(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blueGrey, Colors.lightBlueAccent]
                )
            ),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        VertText(size: mediaQuery.size.height/27),
                        Logo()
                      ],
                    ),
                  ),
                  Container(
                    width: mediaQuery.size.width/1.25,
                    child: Column(
                      children: <Widget>[
                        TextFieldWidget(
                          errorText: 'error',
                          textController: _loginInput,
                          icon: Icons.person,
                          hint: 'Имя пользователя',
                          isObscure: false,
                        ),
                        TextFieldWidget(
                          errorText: 'error',
                          icon: Icons.password,
                          textController: _passwordInput,
                          hint: 'Пароль',
                          isObscure: true,
                        ),
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: RoundedButton(
                      buttonColor: Colors.blue,
                      buttonText: loginButtonText,
                      onPressed: () {
                        final appAuth = new AppAuth(
                            login: _loginInput.text,
                            password: _passwordInput.text,
                            context: context
                        );
                        appAuth.auth();
                      },
                    )
                  )
                ]
            )
        )
    );
  }
}
