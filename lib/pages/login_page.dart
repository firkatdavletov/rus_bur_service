import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rus_bur_service/widgets/text_field.dart';
import 'package:rus_bur_service/widgets/logo.dart';
import 'package:rus_bur_service/widgets/button.dart';
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
    final screenHeight = mediaQuery.size.height - mediaQuery.viewInsets.bottom;
    final screenWidth = mediaQuery.size.width;

    double vertTextSize = screenWidth/20;
    double textFieldPadding = screenWidth/20;
    double textFieldFontSize = limit(screenWidth/20, 30);
    double textFieldIconSize = limit(screenWidth/20, 30);
    double buttonVertPadding = limit(screenWidth/50, 30);
    double buttonHorPadding = limit(screenWidth/7.5, 200);
    double buttonFontSize = limit(screenWidth/20, 30);
    double buttonBottomPadding = screenHeight/35;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            //padding: EdgeInsets.only(top: screenHeight/150, bottom: screenHeight/100),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blueGrey, Colors.lightBlueAccent]
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                    child: Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              VertText(size: vertTextSize),
                              Container(
                                child: Logo(),
                              )
                            ],
                          ),
                        )
                    ),
                  visible: mediaQuery.viewInsets.bottom == 0,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: textFieldPadding),
                    child: Column(
                      children: <Widget>[
                        TextFieldWidget(
                          textController: _loginInput,
                          icon: Icons.person,
                          hint: loginLabelText,
                          isObscure: false,
                          fontSize: textFieldFontSize,
                          iconSize: textFieldIconSize,
                        ),
                        TextFieldWidget(
                          icon: Icons.password,
                          textController: _passwordInput,
                          hint: passwordLabelText,
                          isObscure: true,
                          fontSize: textFieldFontSize,
                          iconSize: textFieldIconSize,
                        ),
                      ],
                    )
                ),
                Container(
                  padding: EdgeInsets.only(bottom: buttonBottomPadding),
                  child: RoundedButton(
                    buttonColor: Colors.blueAccent,
                    horPadding: buttonHorPadding,
                    buttonText: loginButtonText,
                    vertPadding: buttonVertPadding,
                    onPressed: () {  },
                    fontSize: buttonFontSize,
                  ),
                )
              ],
            ),
          )
        )
    );
  }
}

double limit(double value, double limit) {
  if (value <= limit) {
    return value;
  } else {
    return limit;
  }
}
