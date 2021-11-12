import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static const VerticalTextStyle = TextStyle(
    fontSize: 40.0,
    fontWeight: FontWeight.bold,
    color: Colors.white60
  );

  static const InputTextStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal
  );

  static const FocusedLabelTextStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      color: Colors.black54
  );

  static const InputLabelStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      color: Colors.black54
  );

  static const ButtonTextStyle = TextStyle(
     color: Colors.white70
  );
  static const ListTitleStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Colors.black54
  );
  static const ListItemStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      color: Colors.black54
  );
  static const ListSubTitleStyle = TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      color: Colors.black26
  );

  getListSubTitleStyle() {
    return ListSubTitleStyle;
  }
  getListItemStyle() {
    return ListItemStyle;
  }
  getListTitleStyle() {
    return ListTitleStyle;
  }
  getVerticalTextStyle() {
    return VerticalTextStyle;
  }

  getInputTextStyle() {
    return InputTextStyle;
  }

  getInputLabelStyle() {
    return InputLabelStyle;
  }

  getFocusedLabelStyle() {
    return FocusedLabelTextStyle;
  }
  getButtonTextStyle() {
    return ButtonTextStyle;
  }
}

