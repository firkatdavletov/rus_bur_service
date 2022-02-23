import 'package:flutter/material.dart';
import 'package:rus_bur_service/widgets/appbar/app_bar.dart';
import 'package:rus_bur_service/widgets/forms/add_spare_form.dart';

class AddSparePage extends StatelessWidget {
  final bool isNewSpare;
  const AddSparePage({
    Key? key,
    required this.isNewSpare
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          isNewSpare
          ? 'Новая деталь'
          : 'Редактрование детали'
      ),
      body: SingleChildScrollView(
        child: AddSpareForm(isNewSpare: isNewSpare),
      ),
    );
    // return ;
  }
}