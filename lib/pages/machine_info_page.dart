import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/widgets/appbar/app_bar.dart';
import 'package:rus_bur_service/widgets/forms/machine_info_form.dart';

import '../controller/user_notifier.dart';
import '../widgets/drawers/app_drawer.dart';

class MachineInfoPage extends StatelessWidget {
  const MachineInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double _height = MediaQuery.of(context).size.height - 100;

    return Scaffold(
      appBar: myAppBar('Данные машины'),
      drawer: AppDrawer(user: Provider.of<UserNotifier>(context, listen: false).user,),
      body: MachineInfoForm()
    );
  }
}
