import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/picture_notifier.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/main.dart';
import 'package:rus_bur_service/models/picture.dart';
import 'package:rus_bur_service/pages/error_page.dart';
import 'package:rus_bur_service/pages/waiting_page.dart';
import 'package:rus_bur_service/widgets/alert_dialog/take_picture_alert_dialog.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';

typedef void OnPickImageCallback (String name);

class PicturesPage extends StatefulWidget {
  const PicturesPage({Key? key}) : super(key: key);

  @override
  _PicturesPageState createState() => _PicturesPageState();
}

class _PicturesPageState extends State<PicturesPage> {
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
            cardId: 0,
            name: name,
            picture: bytes,
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
                  TakingPictureAlert(),
                  ElevatedButton(
                      onPressed: () {
                        switch (Provider.of<PictureNotifier>(context, listen: false).photoName) {
                          case PhotoName.generalView:
                            context.read<PictureNotifier>().changeAddPhotoName('Главный вид');
                            break;
                          case PhotoName.stateRegNumb:
                            context.read<PictureNotifier>().changeAddPhotoName('Гос. регистрационный номер');
                            break;
                          case PhotoName.generalSerialNumb:
                            context.read<PictureNotifier>().changeAddPhotoName('Серийный номер установки');
                            break;
                          case PhotoName.engineSerialNumb:
                            context.read<PictureNotifier>().changeAddPhotoName('Серийный номер двигателя');
                            break;
                          case PhotoName.additional:
                            // TODO: Handle this case.
                        }
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Фотографии'),
      ),
      drawer: ReportDrawer(),
      body: PicturesGridList(),
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
        ],
      ),
    );
  }
}


class PicturesGridList extends StatefulWidget {
  const PicturesGridList({Key? key}) : super(key: key);

  @override
  _PicturesGridListState createState() => _PicturesGridListState();
}

class _PicturesGridListState extends State<PicturesGridList> {
  _getPictures(int reportId, int cardId) {
    return db.getPicture(reportId, cardId);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getPictures(Provider.of<ReportNotifier>(context, listen: false).id, 0),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return Center(
                child: Text('List is empty'),
              );
            }
            return ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int i) {
                  return Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  GestureDetector(
                                      child: Hero(
                                          tag: snapshot.data[i].name,
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            child: Image.memory(snapshot.data[i].picture),
                                          )
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => FullScreenPage(
                                                  title: snapshot.data[i].name,
                                                  bytes: snapshot.data[i].picture,
                                                )
                                            )
                                        );
                                      }
                                  ),
                                  Text(snapshot.data[i].name)
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.deepOrange,),
                              onPressed: () {
                                setState(() {
                                  db.deletePicture(snapshot.data[i].id);
                                });
                              },
                            )
                          ]
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                      )
                    ],
                  );
                }
            );
          } else if (snapshot.hasError) {
            return ErrorPage();
          } else {
            return WaitingPage();
          }
        }
    );
  }
}

class PictureListItem {
  File imageFile;
  String title;
  PictureListItem({required this.imageFile, required this.title});
}

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





