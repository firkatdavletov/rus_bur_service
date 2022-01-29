import 'package:flutter/material.dart';
import 'package:rus_bur_service/widgets/forms/pictures_settings_form.dart';

class PictureSettingsPage extends StatelessWidget {
  const PictureSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки изображения '),
      ),
      body: SingleChildScrollView(
        child: PicturesSettingsForm()
      ),
    );
  }
}

