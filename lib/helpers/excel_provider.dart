import 'package:flutter/services.dart';
import 'package:rus_bur_service/helpers/mail_sendler.dart';
import 'package:rus_bur_service/helpers/save_file.dart';
import 'package:rus_bur_service/main.dart';
import 'package:rus_bur_service/models/picture.dart';
import 'package:rus_bur_service/models/user.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../models/report.dart';


class ExcelProvider {
  bool success = false;
  bool _imageIsLoaded = false;
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

    Picture logo_1 = sheet.pictures.addStream(
        1, 10, buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    logo_1.height = 150;
    logo_1.width = 300;

    sheet.getRangeByIndex(8, 14).setText('ООО "РусБурСервис"          ');
    sheet.getRangeByIndex(9, 14).setText('ИНН 6670196984, КПП 667001001          ');

    sheet.getRangeByIndex(8, 14, 9, 14).cellStyle = style_1;

    sheet.getRangeByIndex(12, 1).setText('ОТЧЁТ ПО РЕЗУЛЬТАТАМ');
    sheet.getRangeByIndex(13, 1).setText('ДИАГНОСТИКИ БУРОВОГО СТАНКА');
    sheet.getRangeByIndex(14, 1).setText('№${report.name}');

    sheet.getRangeByIndex(12, 1, 12, 14).merge();
    sheet.getRangeByIndex(13, 1, 13, 14).merge();
    sheet.getRangeByIndex(14, 1, 14, 14).merge();

    final Range range_1 = sheet.getRangeByIndex(12, 1, 14, 14);
    range_1.cellStyle = style_2;

    sheet.getRangeByIndex(19, 1).setText('Заказчик: ${report.company}');
    sheet.getRangeByIndex(20, 1).setText('Дата осмотра: ${report.date}');
    sheet.getRangeByIndex(21, 1).setText('Исполнитель: ООО "РусБурСервис"');

    sheet.getRangeByIndex(19, 1, 21, 1).cellStyle = style_3;

    sheet.getRangeByIndex(23, 1).setText('Сервисный инженер: ${user.firstName} ${user.lastName} ${user.middleName}');
    sheet.getRangeByIndex(23, 1).cellStyle = style_4;

    Picture logo_2 = sheet.pictures.addStream(
        27, 12, buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
    logo_2.height = 70;
    logo_2.width = 140;

    sheet.getRangeByIndex(30, 1).setText('Заказчик');
    sheet.getRangeByIndex(30, 4).setText(report.company);
    sheet.getRangeByIndex(31, 1).setText('Место проведения работ');
    sheet.getRangeByIndex(31, 4).setText(report.place);
    sheet.getRangeByIndex(32, 1).setText('Контактное лицо заказчика');
    sheet.getRangeByIndex(32, 4).setText(report.customerName);
    sheet.getRangeByIndex(33, 4).setText('Телефон: ${report.customerPhone}');
    sheet.getRangeByIndex(34, 4).setText('E-mail: ${report.customerEmail}');
    sheet.getRangeByIndex(35, 1).setText('Модель машины');
    sheet.getRangeByIndex(35, 4).setText(report.machineModel);
    sheet.getRangeByIndex(36, 1).setText('Серийный номер машины');
    sheet.getRangeByIndex(36, 4).setText(report.machineNumb);
    sheet.getRangeByIndex(37, 1).setText('Год выпуска');
    sheet.getRangeByIndex(37, 4).setText(report.machineYear);
    sheet.getRangeByIndex(38, 1).setText('Модель двигателя');
    sheet.getRangeByIndex(38, 4).setText(report.engineModel);
    sheet.getRangeByIndex(39, 1).setText('Серийный номер двигателя');
    sheet.getRangeByIndex(39, 4).setText(report.engineNumb);
    sheet.getRangeByIndex(40, 1).setText('Наработка');
    sheet.getRangeByIndex(40, 4).setText(report.opTime);
    sheet.getRangeByIndex(43, 1).setText('Примечания');
    sheet.getRangeByIndex(43, 4).setText(report.note);

    final Range range_2 = sheet.getRangeByIndex(30, 1, 30, 3);
    final Range range_3 = sheet.getRangeByIndex(31, 1, 31, 3);
    final Range range_4 = sheet.getRangeByIndex(32, 1, 34, 3);
    final Range range_5 = sheet.getRangeByIndex(35, 1, 35, 3);
    final Range range_6 = sheet.getRangeByIndex(36, 1, 36, 3);
    final Range range_7 = sheet.getRangeByIndex(37, 1, 37, 3);
    final Range range_8 = sheet.getRangeByIndex(38, 1, 38, 3);
    final Range range_9 = sheet.getRangeByIndex(39, 1, 39, 3);
    final Range range_10 = sheet.getRangeByIndex(40, 1, 42, 3);
    final Range range_11 = sheet.getRangeByIndex(43, 1, 43, 3);
    //
    final Range range_12 = sheet.getRangeByIndex(30, 4, 30, 14);
    final Range range_13 = sheet.getRangeByIndex(31, 4, 31, 14);
    final Range range_14 = sheet.getRangeByIndex(32, 4, 32, 14);
    final Range range_15 = sheet.getRangeByIndex(33, 4, 33, 14);
    final Range range_16 = sheet.getRangeByIndex(34, 4, 34, 14);
    final Range range_17 = sheet.getRangeByIndex(35, 4, 35, 14);
    final Range range_18 = sheet.getRangeByIndex(36, 4, 36, 14);
    final Range range_19 = sheet.getRangeByIndex(37, 4, 37, 14);
    final Range range_20 = sheet.getRangeByIndex(38, 4, 38, 14);
    final Range range_21 = sheet.getRangeByIndex(39, 4, 39, 14);
    final Range range_22 = sheet.getRangeByIndex(40, 4, 40, 14);
    final Range range_23 = sheet.getRangeByIndex(41, 4, 41, 14);
    final Range range_24 = sheet.getRangeByIndex(42, 4, 42, 14);
    final Range range_25 = sheet.getRangeByIndex(43, 4, 43, 14);

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

    sheet.getRangeByIndex(30, 1, 43, 14).cellStyle = style_5;
    sheet.getRangeByIndex(30, 1, 43, 3).cellStyle.backColor = '#DBDBDB';
    sheet.getRangeByIndex(30, 1, 43, 3).cellStyle.vAlign = VAlignType.top;

    // Add images
    var _images = await db.getPicture(report.id, 0);
    print('images: ${_images.length}');
    int x = 6;
    int y = 1;
    int i = 0;
    for (var image in _images) {
      if (i % 3 == 0) {
        y = 1;
        x += 40;
      } else {
        y += 4;
      }
      Picture image1 = sheet.pictures.addStream(x, y, image.picture);
      image1.width = 300;
      image1.height = 500;
      i++;
    }



    //Save and launch the excel.

    final List<int> bytes = workbook.saveAsStream();

    FileSaver().saveAndLaunchFile(bytes, 'reportnew.xlsx');
    MailSender().sendMail('reportnew.xlsx', report.id);
    //Dispose the document.
    workbook.dispose();
  }


}







