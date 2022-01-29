import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/diagnostic_cards_notifier.dart';
import 'package:rus_bur_service/controller/picture_notifier.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/main.dart';
import 'package:rus_bur_service/models/picture.dart';
import 'package:rus_bur_service/pages/create_card_page.dart';
import 'package:rus_bur_service/widgets/alert_dialog/take_card_picture_dialog.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';
import 'package:rus_bur_service/widgets/list_views/card_pictures_list.dart';


typedef void OnPickImageCallback (String name);

class CardPicturesPage extends StatefulWidget {
  const CardPicturesPage({Key? key}) : super(key: key);

  @override
  _CardPicturesPageState createState() => _CardPicturesPageState();
}

class _CardPicturesPageState extends State<CardPicturesPage> {
  ImagePicker _picker = ImagePicker();

  _onImageButtonPressed (ImageSource source, {BuildContext? context}) async {
    await _displayPickImageDialog(context!, (name) async {
      final pickedFile = await _picker.pickImage(source: source);
      File temp = File(pickedFile!.path);
      List<int> bytes = await temp.readAsBytes();
      setState(() {
        AppPicture _picture = AppPicture(
            id: 0,
            reportId: Provider.of<ReportNotifier>(context, listen: false).id,
            cardId: Provider.of<DiagnosticCardsNotifier>(context, listen: false).id,
            name: name,
            //picture: bytes,
            description: ''
        );
        db.insertPicture(_picture);
        imageCache!.clear();
      });
    });
  }

  _displayPickImageDialog (BuildContext context, OnPickImageCallback onPick) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Выберите название фото'),
              content: Container(
                height: 400,
                width: 350,
                child: ListView(
                  children: [
                    TakingCardPictureAlert(),
                    ElevatedButton(
                        onPressed: () {
                          onPick(Provider.of<PictureNotifier>(context, listen: false).addPhotoName);
                        },
                        child: Text('Сделать фото'))
                  ],
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
      ),
      drawer: ReportDrawer(),
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
                context.read<PictureNotifier>().changePhotoName(PhotoName.generalView);
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
                context.read<PictureNotifier>().changePhotoName(PhotoName.generalView);
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
