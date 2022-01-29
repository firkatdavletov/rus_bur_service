import 'dart:io';


import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Hero(
          tag: title,
          child: Image.file(file),
        ),
      ),
    );
  }
}