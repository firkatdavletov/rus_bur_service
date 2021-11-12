import 'package:flutter/material.dart';
import 'package:rus_bur_service/widgets/list_views/expansion_list.dart';

class DiagnosticCardsPage extends StatelessWidget {
  const DiagnosticCardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expansion List'),),
      body: ExpansionList(),
    );
  }
}
