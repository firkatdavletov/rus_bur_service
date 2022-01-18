import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rus_bur_service/controller/report_notifier.dart';
import 'package:rus_bur_service/main.dart';
import 'package:rus_bur_service/models/part.dart';

class AgreedDiaCardsList extends StatelessWidget {
  final List<Part> parts;
  const AgreedDiaCardsList({
    Key? key,
    required this.parts
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: FutureBuilder(
      //     future: db.getOperations(
      //         'Part_id',
      //         '${Provider.of<ReportNotifier>(context, listen: false).id}'),
      //     builder: builder),
    );
  }
}
