import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rus_bur_service/helpers/mail_sendler.dart';
import 'package:rus_bur_service/helpers/save_file.dart';
import 'package:rus_bur_service/models/diagnostic_card.dart';
import 'package:rus_bur_service/models/spare.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../main.dart';
import '../models/report.dart';


class ExcelProvider {
  final BuildContext context;

  ExcelProvider({
    required this.context
  });

  bool success = false;
  Future<void> generateExcel(Report report, User user) async {
    //Create a Excel document.

    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index
    final Worksheet sheet = workbook.worksheets[0];
    sheet.showGridlines = true;

    // Enable calculation for worksheet.
    sheet.enableSheetCalculations();

    final Style style_1 = workbook.styles.add('Style1');
    final Style style_2 = workbook.styles.add('Style2');
    final Style style_3 = workbook.styles.add('Style3');
    final Style style_4 = workbook.styles.add('Style4');
    final Style style_5 = workbook.styles.add('Style5');

    style_1.fontName = 'Times New Roman';
    style_1.fontSize = 12;
    style_1.bold = true;
    style_1.hAlign = HAlignType.right;

    style_2.fontName = 'Times New Roman';
    style_2.fontSize = 22;
    style_2.bold = true;
    style_2.hAlign = HAlignType.center;

    style_3.fontName = 'Times New Roman';
    style_3.fontSize = 18;
    style_3.bold = true;

    style_4.fontName = 'Times New Roman';
    style_4.fontSize = 18;

    style_5.fontName = 'Times New Roman';
    style_5.fontSize = 12;
    style_5.borders.all.lineStyle = LineStyle.thin;

    //Set logo
    ByteData data = await rootBundle.load('assets/images/logo.png');
    final buffer = data.buffer;

    int row = 1;

    Picture logo_1 = sheet.pictures.addStream(
        row, 10, buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    logo_1.height = 150;
    logo_1.width = 300;

    row += 7; //8
    sheet.getRangeByIndex(row, 14).setText('ООО "РусБурСервис"          ');
    sheet.getRangeByIndex(row, 14, row+1, 14).cellStyle = style_1;

    row++; //9
    sheet.getRangeByIndex(row, 14).setText('ИНН 6670196984, КПП 667001001          ');



    row += 3; //12
    sheet.getRangeByIndex(row, 1).setText('ОТЧЁТ ПО РЕЗУЛЬТАТАМ');
    sheet.getRangeByIndex(row, 1, row, 14).merge();
    final Range range_1 = sheet.getRangeByIndex(row, 1, row+2, 14);
    range_1.cellStyle = style_2;

    row++; //13
    sheet.getRangeByIndex(row, 1).setText('ДИАГНОСТИКИ БУРОВОГО СТАНКА');
    sheet.getRangeByIndex(row, 1, row, 14).merge();

    row++; //14
    sheet.getRangeByIndex(row, 1).setText('№${report.name}');
    sheet.getRangeByIndex(row, 1, row, 14).merge();



    row += 5; //19
    sheet.getRangeByIndex(row, 1).setText('Заказчик: ${report.company}');
    sheet.getRangeByIndex(row, 1, row+2, 1).cellStyle = style_3;

    row++; //20
    sheet.getRangeByIndex(row, 1).setText('Дата осмотра: ${report.date}');

    row++; //21
    sheet.getRangeByIndex(row, 1).setText('Исполнитель: ООО "РусБурСервис"');


    row += 2; //23
    sheet.getRangeByIndex(row, 1).setText('Сервисный инженер: ${user.firstName} ${user.lastName} ${user.middleName}');
    sheet.getRangeByIndex(row, 1).cellStyle = style_4;

    row += 4; //27
    Picture logo_2 = sheet.pictures.addStream(
        row, 12, buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    logo_2.height = 70;
    logo_2.width = 140;

    row += 3; // 30
    sheet.getRangeByIndex(row, 1).setText('Заказчик');
    sheet.getRangeByIndex(row, 4).setText(report.company);
    final Range range_2 = sheet.getRangeByIndex(row, 1, row, 3);
    final Range range_12 = sheet.getRangeByIndex(row, 4, row, 14);
    sheet.getRangeByIndex(row, 1, row+13, 14).cellStyle = style_5;
    sheet.getRangeByIndex(row, 1, row+13, 3).cellStyle.backColor = '#DBDBDB';
    sheet.getRangeByIndex(row, 1, row+13, 3).cellStyle.vAlign = VAlignType.top;

    row++; //31
    sheet.getRangeByIndex(row, 1).setText('Место проведения работ');
    sheet.getRangeByIndex(row, 4).setText(report.place);
    final Range range_3 = sheet.getRangeByIndex(row, 1, row, 3);
    final Range range_13 = sheet.getRangeByIndex(row, 4, row, 14);

    row++; //32
    sheet.getRangeByIndex(row, 1).setText('Контактное лицо заказчика');
    sheet.getRangeByIndex(row, 4).setText(report.customerName);
    final Range range_4 = sheet.getRangeByIndex(row, 1, row+2, 3);
    final Range range_14 = sheet.getRangeByIndex(row, 4, row, 14);

    row++; //33
    sheet.getRangeByIndex(row, 4).setText('Телефон: ${report.customerPhone}');
    final Range range_15 = sheet.getRangeByIndex(row, 4, row, 14);

    row++; //34
    sheet.getRangeByIndex(row, 4).setText('E-mail: ${report.customerEmail}');
    final Range range_16 = sheet.getRangeByIndex(row, 4, row, 14);

    row++;//35
    sheet.getRangeByIndex(row, 1).setText('Модель машины');
    sheet.getRangeByIndex(row, 4).setText(report.machineModel);
    final Range range_5 = sheet.getRangeByIndex(row, 1, row, 3);
    final Range range_17 = sheet.getRangeByIndex(row, 4, row, 14);

    row++; //36
    sheet.getRangeByIndex(row, 1).setText('Серийный номер машины');
    sheet.getRangeByIndex(row, 4).setText(report.machineNumb);
    final Range range_6 = sheet.getRangeByIndex(row, 1, row, 3);
    final Range range_18 = sheet.getRangeByIndex(row, 4, row, 14);

    row++; //37
    sheet.getRangeByIndex(row, 1).setText('Год выпуска');
    sheet.getRangeByIndex(row, 4).setText(report.machineYear);
    final Range range_7 = sheet.getRangeByIndex(row, 1, row, 3);
    final Range range_19 = sheet.getRangeByIndex(row, 4, row, 14);

    row++; //38
    sheet.getRangeByIndex(row, 1).setText('Модель двигателя');
    sheet.getRangeByIndex(row, 4).setText(report.engineModel);
    final Range range_8 = sheet.getRangeByIndex(row, 1, row, 3);
    final Range range_20 = sheet.getRangeByIndex(row, 4, row, 14);

    row++; //39
    sheet.getRangeByIndex(row, 1).setText('Серийный номер двигателя');
    sheet.getRangeByIndex(row, 4).setText(report.engineNumb);
    final Range range_9 = sheet.getRangeByIndex(row, 1, row, 3);
    final Range range_21 = sheet.getRangeByIndex(row, 4, row, 14);

    row++; //40
    sheet.getRangeByIndex(row, 1).setText('Наработка');
    sheet.getRangeByIndex(row, 4).setText('${report.opTime_1} м/ч');
    final Range range_10 = sheet.getRangeByIndex(row, 1, row+2, 3);
    final Range range_22 = sheet.getRangeByIndex(row, 4, row, 14);

    row++; //41
    sheet.getRangeByIndex(row, 1).setText('Наработка');
    sheet.getRangeByIndex(row, 4).setText('${report.opTime_2} уд/ч');
    final Range range_23 = sheet.getRangeByIndex(row, 4, row, 14);

    row++; //42
    sheet.getRangeByIndex(row, 1).setText('Наработка');
    sheet.getRangeByIndex(row, 4).setText('${report.opTime_3} пог/м');
    final Range range_24 = sheet.getRangeByIndex(row, 4, row, 14);

    row++; //43
    sheet.getRangeByIndex(row, 1).setText('Примечания');
    sheet.getRangeByIndex(row, 4).setText(report.note);
    final Range range_11 = sheet.getRangeByIndex(row, 1, row, 3);
    final Range range_25 = sheet.getRangeByIndex(row, 4, row, 14);

    range_2.merge();
    range_3.merge();
    range_4.merge();
    range_5.merge();
    range_6.merge();
    range_7.merge();
    range_8.merge();
    range_9.merge();
    range_10.merge();
    range_11.merge();
    range_12.merge();
    range_13.merge();
    range_14.merge();
    range_15.merge();
    range_16.merge();
    range_17.merge();
    range_18.merge();
    range_19.merge();
    range_20.merge();
    range_21.merge();
    range_22.merge();
    range_23.merge();
    range_24.merge();
    range_25.merge();

    // Add images
    row += 3; //46
    var _images = await db.getPicture(report.id, '');
    int column = 1;
    for (var image in _images) {
      sheet.getRangeByIndex(row, 1).setText('${image.name}');
      row++;
      sheet.getRangeByIndex(row, 1).setText('${image.description}');
      row++;
      sheet.pictures.addStream(row, column, image.picture);
      row += 70;
    }

    row++;
    List<DiagnosticCard> _cards = await db.getCards(report.id);
    List<String> _cardsId = [];

    sheet.getRangeByIndex(row, 1).setText('РЕКОМЕНДУЕМЫЕ МЕРОПРИЯТИЯ ПО РЕЗУЛЬТАТАМ ПРОВЕРКИ');

    row++;
    sheet.getRangeByIndex(row, 1).setText('ПРИОРИТЕТ - ВАЖНО');

    row++;
    sheet.getRangeByIndex(row, 1).setText('№ диагн-кой карты');
    sheet.getRangeByIndex(row, 2).setText('Узел/система');
    sheet.getRangeByIndex(row, 4).setText('Описание проблемы');
    sheet.getRangeByIndex(row, 7).setText('Решение');
    sheet.getRangeByIndex(row, 10).setText('Риски, положительный эффект');
    sheet.getRangeByIndex(row, 13).setText('Страница отчёта');
    sheet.getRangeByIndex(row, 14).setText('Кол-во чел./ч');

    row++;
    for (DiagnosticCard c in _cards) {
      _cardsId.add(c.id);
      if (c.priority == 3) {
        sheet.getRangeByIndex(row, 1).setText(c.id);
        sheet.getRangeByIndex(row, 2).setText(c.area);
        sheet.getRangeByIndex(row, 4).setText(c.description);
        sheet.getRangeByIndex(row, 7).setText(c.recommend);
        sheet.getRangeByIndex(row, 10).setText(c.effect);
        sheet.getRangeByIndex(row, 13).setText('n/a');
        sheet.getRangeByIndex(row, 14).setText('${c.manHours}');
        row++;
      }
    }
    //
    List<Spare> _spares = await db.getSparesReport(_cardsId);

    row++;
    sheet.getRangeByIndex(row, 1).setText('ПРИОРИТЕТ - ПЛАНОВО');

    row++;
    sheet.getRangeByIndex(row, 1).setText('№ диагн-кой карты');
    sheet.getRangeByIndex(row, 2).setText('Узел/система');
    sheet.getRangeByIndex(row, 4).setText('Описание проблемы');
    sheet.getRangeByIndex(row, 7).setText('Решение');
    sheet.getRangeByIndex(row, 10).setText('Риски, положительный эффект');
    sheet.getRangeByIndex(row, 13).setText('Страница отчёта');
    sheet.getRangeByIndex(row, 14).setText('Кол-во чел./ч');

    row++;
    for (DiagnosticCard c in _cards) {
      if (c.priority == 2) {
        sheet.getRangeByIndex(row, 1).setText(c.id);
        sheet.getRangeByIndex(row, 2).setText(c.area);
        sheet.getRangeByIndex(row, 4).setText(c.description);
        sheet.getRangeByIndex(row, 7).setText(c.recommend);
        sheet.getRangeByIndex(row, 10).setText(c.effect);
        sheet.getRangeByIndex(row, 13).setText('n/a');
        sheet.getRangeByIndex(row, 14).setText('${c.manHours}');
        row++;
      }
    }

    row++;
    sheet.getRangeByIndex(row, 1).setText('ПРИОРИТЕТ – РЕКОМЕНДАЦИИ, ПРЕДЛОЖЕНИЯ ПО УЛУЧШЕНИЮ, МОДЕРНИЗАЦИИ ОБОРУДОВАНИЯ');

    row++;
    sheet.getRangeByIndex(row, 1).setText('№ диагн-кой карты');
    sheet.getRangeByIndex(row, 2).setText('Узел/система');
    sheet.getRangeByIndex(row, 4).setText('Описание проблемы');
    sheet.getRangeByIndex(row, 7).setText('Решение');
    sheet.getRangeByIndex(row, 10).setText('Риски, положительный эффект');
    sheet.getRangeByIndex(row, 13).setText('Страница отчёта');
    sheet.getRangeByIndex(row, 14).setText('Кол-во чел./ч');

    // row++;
    // for (Spare s in _spares) {
    //   if (s.priority == 1) {
    //     sheet.getRangeByIndex(row, 1).setText(s.cardId);
    //     sheet.getRangeByIndex(row, 2).setText(s.);
    //     sheet.getRangeByIndex(row, 4).setText(c.description);
    //     sheet.getRangeByIndex(row, 7).setText(c.recommend);
    //     sheet.getRangeByIndex(row, 10).setText(c.effect);
    //     sheet.getRangeByIndex(row, 13).setText('n/a');
    //     sheet.getRangeByIndex(row, 14).setText('${c.manHours}');
    //     row++;
    //   }
    // }

    row++;
    sheet.getRangeByIndex(row, 1).setText('ПЕРЕЧЕНЬ НЕОБХОДИМЫХ ЗАПЧАСТЕЙ');

    row++;
    sheet.getRangeByIndex(row, 1).setText('ПРИОРИТЕТ - ВАЖНО');

    row++;
    sheet.getRangeByIndex(row, 1).setText('№ диагн-кой карты');
    sheet.getRangeByIndex(row, 2).setText('Каталожный номер');
    sheet.getRangeByIndex(row, 4).setText('Наименование');
    sheet.getRangeByIndex(row, 6).setText('Кол-во');
    sheet.getRangeByIndex(row, 7).setText('Ед. изм.');
    sheet.getRangeByIndex(row, 8).setText('Узел/система');
    sheet.getRangeByIndex(row, 10).setText('Проблема');
    sheet.getRangeByIndex(row, 14).setText('Страница отчета');

    row++;
    for (DiagnosticCard c in _cards) {
      _cardsId.add(c.id);
      if (c.priority == 3) {
        sheet.getRangeByIndex(row, 1).setText(c.id);
        sheet.getRangeByIndex(row, 2).setText(c.area);
        sheet.getRangeByIndex(row, 4).setText(c.description);
        sheet.getRangeByIndex(row, 7).setText(c.recommend);
        sheet.getRangeByIndex(row, 10).setText(c.effect);
        sheet.getRangeByIndex(row, 13).setText('n/a');
        sheet.getRangeByIndex(row, 14).setText('${c.manHours}');
        row++;
      }
    }

    row++;
    sheet.getRangeByIndex(row, 1).setText('ПРИОРИТЕТ - ПЛАНОВО');

    row++;
    sheet.getRangeByIndex(row, 1).setText('№ диагн-кой карты');
    sheet.getRangeByIndex(row, 2).setText('Узел/система');
    sheet.getRangeByIndex(row, 4).setText('Описание проблемы');
    sheet.getRangeByIndex(row, 7).setText('Решение');
    sheet.getRangeByIndex(row, 10).setText('Риски, положительный эффект');
    sheet.getRangeByIndex(row, 13).setText('Страница отчёта');
    sheet.getRangeByIndex(row, 14).setText('Кол-во чел./ч');

    row++;
    for (DiagnosticCard c in _cards) {
      if (c.priority == 2) {
        sheet.getRangeByIndex(row, 1).setText(c.id);
        sheet.getRangeByIndex(row, 2).setText(c.area);
        sheet.getRangeByIndex(row, 4).setText(c.description);
        sheet.getRangeByIndex(row, 7).setText(c.recommend);
        sheet.getRangeByIndex(row, 10).setText(c.effect);
        sheet.getRangeByIndex(row, 13).setText('n/a');
        sheet.getRangeByIndex(row, 14).setText('${c.manHours}');
        row++;
      }
    }

    row++;
    sheet.getRangeByIndex(row, 1).setText('ПРИОРИТЕТ – РЕКОМЕНДАЦИИ, ПРЕДЛОЖЕНИЯ ПО УЛУЧШЕНИЮ, МОДЕРНИЗАЦИИ ОБОРУДОВАНИЯ');

    row++;
    sheet.getRangeByIndex(row, 1).setText('№ диагн-кой карты');
    sheet.getRangeByIndex(row, 2).setText('Узел/система');
    sheet.getRangeByIndex(row, 4).setText('Описание проблемы');
    sheet.getRangeByIndex(row, 7).setText('Решение');
    sheet.getRangeByIndex(row, 10).setText('Риски, положительный эффект');
    sheet.getRangeByIndex(row, 13).setText('Страница отчёта');
    sheet.getRangeByIndex(row, 14).setText('Кол-во чел./ч');

    row++;
    for (DiagnosticCard c in _cards) {
      if (c.priority == 1) {
        sheet.getRangeByIndex(row, 1).setText(c.id);
        sheet.getRangeByIndex(row, 2).setText(c.area);
        sheet.getRangeByIndex(row, 4).setText(c.description);
        sheet.getRangeByIndex(row, 7).setText(c.recommend);
        sheet.getRangeByIndex(row, 10).setText(c.effect);
        sheet.getRangeByIndex(row, 13).setText('n/a');
        sheet.getRangeByIndex(row, 14).setText('${c.manHours}');
        row++;
      }
    }





    //Save and launch the excel.

    final List<int> bytes = workbook.saveAsStream();

    FileSaver().saveAndLaunchFile(bytes, 'reportnew.xlsx');
    print('ExcelProvider: created file');
    MailSender(context: context).sendMail('reportnew.xlsx', report.id);
    //Dispose the document.
    workbook.dispose();
  }


}







