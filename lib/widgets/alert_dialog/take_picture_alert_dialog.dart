import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/picture_notifier.dart';
import 'package:rus_bur_service/widgets/forms/app_text_form_field.dart';

class TakingPictureAlert extends StatefulWidget {
  const TakingPictureAlert({Key? key}) : super(key: key);

  @override
  _TakingPictureAlertState createState() => _TakingPictureAlertState();
}

class _TakingPictureAlertState extends State<TakingPictureAlert> {
  bool isAdditional = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: AppTextFormField(
                helperText: '',
                onChanged: (String value) {
                  context.read<PictureNotifier>().changeAddPhotoName(value);
                },
                validator: (String value) {

                },
                icon: Icon(Icons.text_format), //Icon(Icons.light, color: Colors.brown,),
                label: 'Название фото'
            ),
          visible: isAdditional,
        ),
        AppTextFormField(
            helperText: '',
            onChanged: (String value) {
              context.read<PictureNotifier>().changePictureDescription(value);
            },
            validator: (String value) {

            },
            icon: Icon(Icons.text_format), //Icon(Icons.light, color: Colors.brown,),
            label: 'Описание фото'
        ),
      ],
    );
  }
}

