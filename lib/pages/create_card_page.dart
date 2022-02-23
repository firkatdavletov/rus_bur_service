import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/diagnostic_cards_notifier.dart';
import 'package:rus_bur_service/pages/agreed_diagnostic_cards_page.dart';
import 'package:rus_bur_service/widgets/forms/create_card_form.dart';

class CreateCardPage extends StatelessWidget {
  const CreateCardPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _id = '${Provider.of<DiagnosticCardsNotifier>(context, listen: false).id}';
    String _name = '${Provider.of<DiagnosticCardsNotifier>(context, listen: false).name}';
    String _partName = '${Provider.of<DiagnosticCardsNotifier>(context, listen: false).part}';
    return Scaffold(
      appBar: AppBar(
        title: Text('$_partName - $_name #$_id'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AgreedDiagnosticCardsPage()
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
      body: CreateCardForm()
    );
  }
}
