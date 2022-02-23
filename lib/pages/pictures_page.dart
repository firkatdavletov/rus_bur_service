import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/picture_notifier.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/helpers/file_provider.dart';
import 'package:rus_bur_service/main.dart';
import 'package:rus_bur_service/models/picture.dart';
import 'package:rus_bur_service/pages/agreed_diagnostic_areas_page.dart';
import 'package:rus_bur_service/pages/machine_info_page.dart';
import 'package:rus_bur_service/widgets/appbar/app_bar.dart';
import 'package:rus_bur_service/widgets/list_views/report_pictures_list.dart';

import '../controller/user_notifier.dart';
import '../widgets/drawers/app_drawer.dart';
import '../widgets/forms/app_text_form_field.dart';

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
        var _random = Random();
        var _id = _random.nextInt(2147483645);
        AppPicture _picture = AppPicture(
            id: 0,
            reportId: Provider.of<ReportNotifier>(context, listen: false).id,
            cardId: '',
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
          return AlertDialog(
            title: Text('Выберите название фото'),
            content: Container(
              height: 450,
              width: 350,
              child: SingleChildScrollView(
                reverse: true,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      RadioList(),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
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
                              Navigator.pop(context);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo_outlined),
                              SizedBox(width: 10.0),
                              Text('Сделать фото')
                            ],
                          ),
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(200.0, 38.7))
                          ),
                      ),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cancel_outlined),
                              SizedBox(width: 10.0),
                              Text('Отмена')
                            ],
                          ),
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(200.0, 38.7))
                        ),
                      )
                    ],
                  ),
                )
              )
            )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: myAppBar('Фотографии'),
      drawer: AppDrawer(user: Provider.of<UserNotifier>(context, listen: false).user,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReportPicturesList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: ElevatedButton (
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
                        _width > 400
                            ? Text('Данные машины')
                            : Text(''),
                      ],
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: ElevatedButton (
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
                        _width > 400
                            ? Text('Выбрать области')
                            : Text(''),
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



class RadioList extends StatefulWidget {
  const RadioList({Key? key}) : super(key: key);

  @override
  _RadioListState createState() => _RadioListState();
}
bool isAdditional = false;
class _RadioListState extends State<RadioList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile<PhotoName>(
            title: Text('Главный вид'),
            value: PhotoName.generalView,
            groupValue: Provider.of<PictureNotifier>(context, listen: false).photoName,
            onChanged: (PhotoName? value) {
              setState(() {
                isAdditional = false;
                context.read<PictureNotifier>().changePhotoName(value!);
              });
            }
        ),
        RadioListTile<PhotoName>(
            title: Text('Гос. регистрационный номер'),
            value: PhotoName.stateRegNumb,
            groupValue: Provider.of<PictureNotifier>(context, listen: false).photoName,
            onChanged: (PhotoName? value) {
              setState(() {
                isAdditional = false;
                context.read<PictureNotifier>().changePhotoName(value!);
              });
            }
        ),
        RadioListTile<PhotoName>(
            title: Text('Серийный номер установки'),
            value: PhotoName.generalSerialNumb,
            groupValue: Provider.of<PictureNotifier>(context, listen: false).photoName,
            onChanged: (PhotoName? value) {
              setState(() {
                isAdditional = false;
                context.read<PictureNotifier>().changePhotoName(value!);
              });
            }
        ),
        RadioListTile<PhotoName>(
            title: Text('Серийный номер двигателя'),
            value: PhotoName.engineSerialNumb,
            groupValue: Provider.of<PictureNotifier>(context, listen: false).photoName,
            onChanged: (PhotoName? value) {
              setState(() {
                isAdditional = false;
                context.read<PictureNotifier>().changePhotoName(value!);
              });
            }
        ),
        RadioListTile<PhotoName>(
            title: Text('Дополнительное фото'),
            value: PhotoName.additional,
            groupValue: Provider.of<PictureNotifier>(context, listen: false).photoName,
            onChanged: (PhotoName? value) {
              setState(() {
                isAdditional = true;
                context.read<PictureNotifier>().changePhotoName(value!);
              });
            }
        ),
        Visibility(
          child: AppTextFormFieldWithoutIcon(
              helperText: '',
              onChanged: (String value) {
                context.read<PictureNotifier>().changeAddPhotoName(value);
              },
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Заполните поле';
                }
              },
              label: 'Название фото'
          ),
          visible: isAdditional,
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
      ],
    );
  }
}








