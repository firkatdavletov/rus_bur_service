import 'package:flutter/material.dart';
import 'package:rus_bur_service/widgets/forms/authorization_form.dart';
import 'package:rus_bur_service/widgets/logo.dart';
import 'package:rus_bur_service/widgets/vertical_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
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
                  child: _width > 400
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: VerticalText(text: 'АВТОРИЗАЦИЯ'),
                        )
                      : Text('')
              ),
              Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Logo(),
                      AuthorizationForm()
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
    );
  }
}
