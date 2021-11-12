import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';
import 'dart:io';

import 'package:rus_bur_service/widgets/list_views/pictures_grid_list.dart';

class PicturesPage extends StatefulWidget {
  const PicturesPage({Key? key}) : super(key: key);

  @override
  _PicturesPageState createState() => _PicturesPageState();
}

class _PicturesPageState extends State<PicturesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Фотографии'),
      ),
      drawer: ReportDrawer(),
      body: PicturesGridList()
    );
  }
}

