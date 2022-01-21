import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/picture_notifier.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/main.dart';
import 'package:rus_bur_service/models/picture.dart';
import 'package:rus_bur_service/pages/agreed_diagnostic_areas_page.dart';
import 'package:rus_bur_service/pages/machine_info_page.dart';
import 'package:rus_bur_service/widgets/alert_dialog/take_picture_alert_dialog.dart';
import 'package:rus_bur_service/widgets/drawers/report_drawer.dart';
import 'package:rus_bur_service/widgets/list_views/report_pictures_list.dart';

typedef void OnPickImageCallback (String name, String desc);

class PicturesPage extends StatefulWidget {
  const PicturesPage({Key? key}) : super(key: key);

  @override
  _PicturesPageState createState() => _PicturesPageState();
}

class _PicturesPageState extends State<PicturesPage> {
  ImagePicker _picker = ImagePicker();

  _onImageButtonPressed (ImageSource source, {BuildContext? context}) async {
    await _displayPickImageDialog(context!, (name, desc) async {
      final pickedFile = await _picker.pickImage(source: source);
      File temp = File(pickedFile!.path);
      List<int> bytes = await temp.readAsBytes();
      setState(() {
        AppPicture _picture = AppPicture(
            id: 0,
            reportId: Provider.of<ReportNotifier>(context, listen: false).id,
            cardId: '',
            name: name,
            picture: bytes,
            description: desc
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
                        onPick(
                            Provider.of<PictureNotifier>(context, listen: false).addPhotoName,
                            Provider.of<PictureNotifier>(context, listen: false).pictureDescription
                        );
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReportPicturesList(),
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
                              builder: (context) => MachineInfoPage()
                          )
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios),
                        Container(width: 5,),
                        Text('Данные машины'),
                      ],
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: OutlinedButton (
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AgreedDiagnosticAreas()
                          )
                      );
                    },
                    child: Row(
                      children: [
                        Text('Выбрать области'),
                        Container(width: 5,),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    )
                ),
              )
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





