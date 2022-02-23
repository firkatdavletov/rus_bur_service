import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/widgets/appbar/app_bar.dart';
import 'package:rus_bur_service/widgets/list_views/parts_list.dart';

import '../controller/user_notifier.dart';
import '../widgets/drawers/app_drawer.dart';

class AgreedDiagnosticAreas extends StatelessWidget {
  const AgreedDiagnosticAreas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Согласование направлений диагностики'),
      drawer: AppDrawer(user: Provider.of<UserNotifier>(context, listen: false).user,),
      body: PartsList(),
    );
  }
}


