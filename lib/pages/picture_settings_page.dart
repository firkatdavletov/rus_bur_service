import 'package:flutter/material.dart';
import 'package:rus_bur_service/widgets/appbar/app_bar.dart';
import 'package:rus_bur_service/widgets/forms/pictures_settings_form.dart';

class PictureSettingsPage extends StatelessWidget {
  const PictureSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Настройки изображения'),
      body: SingleChildScrollView(
        child: PicturesSettingsForm()
      ),
    );
  }
}

