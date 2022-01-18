import 'dart:typed_data';

import 'package:flutter/material.dart';

class FullScreenPage extends StatelessWidget {
  final Uint8List bytes;
  final String title;
  const FullScreenPage({
    Key? key,
    required this.bytes,
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
          child: Image.memory(bytes),
        ),
      ),
    );
  }
}