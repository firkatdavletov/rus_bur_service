import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditUserTextField extends StatelessWidget {
  // final String initialValue;
  final String labelText;
  final TextEditingController textEditingController;
  const EditUserTextField({
    Key? key,
    // required this.initialValue,
    required this.labelText,
    required this.textEditingController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            width: 300.0,
            child: TextFormField(
              controller: textEditingController,
              // initialValue: initialValue,
              readOnly: false,
              decoration: InputDecoration(
                prefix: Container(
                  width: 100,
                  child: Text(
                    labelText
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  borderSide: BorderSide(
                    width: 2.0,
                    color: Colors.blueGrey
                  ),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
