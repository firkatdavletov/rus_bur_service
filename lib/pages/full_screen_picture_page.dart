import 'dart:io';


import 'package:flutter/material.dart';
import 'package:rus_bur_service/widgets/appbar/app_bar.dart';

class FullScreenPage extends StatelessWidget {
  final File file;
  final String title;
  const FullScreenPage({
    Key? key,
    required this.file,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title),
      body: Center(
        child: Hero(
          tag: title,
          child: Image.file(file),
        ),
      ),
    );
  }
}