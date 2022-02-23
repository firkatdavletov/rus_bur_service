import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/diagnostic_cards_notifier.dart';
import 'package:rus_bur_service/controller/picture_notifier.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/helpers/file_provider.dart';
import 'package:rus_bur_service/main.dart';
import 'package:rus_bur_service/models/picture.dart';
import 'package:rus_bur_service/pages/create_card_page.dart';
import 'package:rus_bur_service/widgets/list_views/card_pictures_list.dart';

import '../widgets/forms/app_text_form_field.dart';


typedef void OnPickImageCallback (String name, String desc);

class CardPicturesPage extends StatefulWidget {
  const CardPicturesPage({Key? key}) : super(key: key);

  @override
  _CardPicturesPageState createState() => _CardPicturesPageState();
}

class _CardPicturesPageState extends State<CardPicturesPage> {
  ImagePicker _picker = ImagePicker();

  _onImageButtonPressed (ImageSource source, {BuildContext? context}) async {
    await _displayPickImageDialog(context!, (name, desc) async {
      final pickedFile = await _picker.pickImage(source: source);
      File temp = File(pickedFile!.path);
      List<int> bytes = await temp.readAsBytes();
      setState(() {
        var _random = Random();
        var _id = _random.nextInt(2147483645);
        AppPicture _picture = AppPicture(
            id: _id,
            reportId: Provider.of<ReportNotifier>(context, listen: false).id,
            cardId: Provider.of<DiagnosticCardsNotifier>(context, listen: false).id,
            name: name,
            description: desc,
            pictureFileName: _id
        );
        FileProvider().save(bytes, '$_id.jpg');
        db.insertPicture(_picture);
        imageCache!.clear();
      });
    });
  }

  _displayPickImageDialog (BuildContext context, OnPickImageCallback onPick) async {
    final _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          context.read<PictureNotifier>().changePictureDescription('');
          context.read<PictureNotifier>().changeAddPhotoName('');
          return AlertDialog(
              title: Text('Введите название и описание фото', textAlign: TextAlign.center,),
              content: Container(
                height: 250,
                width: 350,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppTextFormFieldWithoutIcon(
                              helperText: '',
                              onChanged: (String value) {
                                context.read<PictureNotifier>().changeAddPhotoName(value);
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Пожалуйста, заполните поле';
                                }
                              },
                              label: 'Название фото'
                          ),
                          AppTextFormFieldWithoutIcon(
                              helperText: '',
                              onChanged: (String value) {
                                context.read<PictureNotifier>().changePictureDescription(value);
                              },
                              validator: (String value) {

                              },
                              label: 'Описание фото'
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  onPick(
                                      Provider.of<PictureNotifier>(context, listen: false).addPhotoName,
                                      Provider.of<PictureNotifier>(context, listen: false).pictureDescription
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              child: Text('Сделать фото')
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Отмена')
                          )
                        ],
                      )
                  ),
                ),
              )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    String _id = '${Provider.of<DiagnosticCardsNotifier>(context, listen: false).id}';
    String _name = '${Provider.of<DiagnosticCardsNotifier>(context, listen: false).name}';
    return Scaffold(
      appBar: AppBar(
        title: Text('Фотографии'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateCardPage()
                )
            );
          },
        ),
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CardPicturesList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: OutlinedButton (
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateCardPage()
                          )
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios),
                        Container(width: 5,),
                        _width > 400
                            ? Text('$_name #$_id')
                            : Text(''),
                      ],
                    )
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Semantics(
            label: 'image_picker_example_from_gallery',
            child: FloatingActionButton(
              onPressed: () {
                _onImageButtonPressed(ImageSource.gallery, context: context);
              },
              heroTag: 'image0',
              tooltip: 'Pick Image from gallery',
              child: const Icon(Icons.photo),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'image1',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
  }
}
