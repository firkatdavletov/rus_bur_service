import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rus_bur_service/widgets/forms/registration_form.dart';
import 'package:rus_bur_service/widgets/logo.dart';
import 'package:rus_bur_service/widgets/vertical_text.dart';


String login = '';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blueGrey, Colors.lightBlueAccent]
                )
            ),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: VerticalText(text: 'РЕГИСТРАЦИЯ'),
                    )
                ),
                Expanded(
                    flex: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Logo(),
                        RegistrationForm()
                      ],
                    )
                ),
                Expanded(
                    flex: 1,
                    child: Container()
                )
              ],
            )
        ),
      ),
    );
  }
}

