import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rus_bur_service/auth.dart';

class InputLogin extends StatefulWidget {
  const InputLogin({Key? key}) : super(key: key);

  @override
  _InputLoginState createState() => _InputLoginState();
}

class _InputLoginState extends State<InputLogin> {
  TextEditingController _login = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: _login,
          keyboardType: TextInputType.name,
          style: Theme.of(context).textTheme.headline4,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person, color: Colors.white70,),
            labelText: 'Введите имя пользователя',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: Colors.white70,
                width: 2.0
              )
            ),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                    color: Colors.white70,
                    width: 2.0
                )
            ),
            fillColor: Colors.white70,
          ),
        ),
      ),
    );
  }
}
