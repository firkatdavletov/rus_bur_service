import 'package:flutter/material.dart';

AppBar myAppBar(String title) {
  return AppBar(
    centerTitle: true,
    title: Text(title),
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blueGrey, Colors.lightBlueAccent]
          )
      ),
    ),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(30))
    ),
  );
}