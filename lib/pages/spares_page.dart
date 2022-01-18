import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/diagnostic_cards_notifier.dart';
import 'package:rus_bur_service/models/spare.dart';
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
      ),
      body: SingleChildScrollView(
        child: SparesList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Spare _newSpare = Spare(
              id: 0,
              number: '',
              quantity: 0,
              name: '',
              measure: '',
              issue: '',
              cardId: Provider.of<DiagnosticCardsNotifier>(context, listen: false).id
          );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddSparePage(spare: _newSpare, isNewSpare: true,)
              )
          );
        },
        label: Text('Добавить'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
