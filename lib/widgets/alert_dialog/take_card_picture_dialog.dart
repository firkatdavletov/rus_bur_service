import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rus_bur_service/controller/picture_notifier.dart';
import 'package:rus_bur_service/widgets/forms/app_text_form_field.dart';

class TakingCardPictureAlert extends StatefulWidget {
  const TakingCardPictureAlert({Key? key}) : super(key: key);

  @override
  _TakingCardPictureAlertState createState() => _TakingCardPictureAlertState();
}

class _TakingCardPictureAlertState extends State<TakingCardPictureAlert> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Дополнительное фото'),
        AppTextFormField(
            helperText: '',
            onChanged: (String value) {
              context.read<PictureNotifier>().changeAddPhotoName(value);
            },
            validator: (String value) {

            },
            icon: Icon(Icons.text_format), //Icon(Icons.light, color: Colors.brown,),
            label: 'Название фото'
        ),
      ],
    );
  }
}
