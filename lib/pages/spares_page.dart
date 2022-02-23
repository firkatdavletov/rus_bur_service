import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/spare_notifier.dart';
import 'package:rus_bur_service/pages/create_card_page.dart';
import 'package:rus_bur_service/widgets/list_views/spares_list.dart';
import 'add_spare_page.dart';

class SparesPage extends StatelessWidget {
  const SparesPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Перечень запчастей'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: ()
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateCardPage()
                )
            );
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blueGrey, Colors.lightBlueAccent]
              )
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30))
        ),
      ),
      body: SingleChildScrollView(
        child: SparesList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<SpareNotifier>().changeIssue('');
          context.read<SpareNotifier>().changeNumber('');
          context.read<SpareNotifier>().changeName('');
          context.read<SpareNotifier>().changeQuantity(1);
          context.read<SpareNotifier>().changeMeasure('');
          context.read<SpareNotifier>().changePriority(1);
          context.read<SpareNotifier>().changeId(0);
          //
          // Spare _newSpare = Spare(
          //     id: 0,
          //     number: '',
          //     quantity: 0,
          //     name: '',
          //     measure: '',
          //     issue: '',
          //     cardId: Provider.of<DiagnosticCardsNotifier>(context, listen: false).id,
          //     priority: 0,
          //     part: Provider.of<DiagnosticCardsNotifier>(context, listen: false).part
          // );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddSparePage(isNewSpare: true,)
              )
          );
        },
        label: Text('Добавить'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
