import 'package:flutter/material.dart';
import 'package:rus_bur_service/styles/text_style.dart';

class ReportsListItem extends StatelessWidget {
  final String name;
  final String date;
  final String customer;
  final String machine;
  const ReportsListItem({
    Key? key,
    required this.name,
    required this.date,
    required this.customer,
    required this.machine
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
          Text(name, style: AppTextStyle().getListTitleStyle(),),
          Text(date, style: AppTextStyle().getListItemStyle(),),
          Text(customer, style: AppTextStyle().getListItemStyle(),),
        ],
    );
  }
}
