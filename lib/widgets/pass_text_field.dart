import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  const InputPassword({Key? key}) : super(key: key);

  @override
  _InputPasswordState createState() => _InputPasswordState();
}

class _InputPasswordState extends State<InputPassword> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          obscureText: _showPassword,
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.headline4,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.password, color: Colors.white70),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: this._showPassword ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() => this._showPassword = !this._showPassword);
              },

            ),
            labelText: 'Введите пароль*',
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

