import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:rus_bur_service/styles/text_style.dart';

class PictureGridItem extends StatefulWidget {
  final String title;
  const PictureGridItem({
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  _PictureGridItemState createState() => _PictureGridItemState();
}

class _PictureGridItemState extends State<PictureGridItem> {
  late final XFile? _image;
  bool _enableImage = false;
  ImagePicker _picker = ImagePicker();
  _openGallery(BuildContext context) async {
    _image = await _picker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      _enableImage = _image == null? false: true;
      Navigator.of(context).pop();
    });
  }
  _openCamera(BuildContext context) async {
    _image = await _picker.pickImage(source: ImageSource.camera);
    this.setState(() {
      _enableImage = _image == null? false: true;
      Navigator.of(context).pop();
    });
  }
  _showChoiceDialog (BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Выбери источник фото:'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text('Галерея'),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text('Камера'),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            child:
              !_enableImage?
              Image(image: AssetImage('assets/images/empty.jpg')):
              Image.file(File(_image!.path), height: 150,),
        onTap: () {

        },
      ),
    ),
        header: Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent
          ),
          child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: AppTextStyle().getListItemStyle()
          ),
        ),
        footer: ElevatedButton(
            onPressed: () {
              _showChoiceDialog(context);
            },
            child: Text('Добавить фото')
        ),
    );
  }
}
