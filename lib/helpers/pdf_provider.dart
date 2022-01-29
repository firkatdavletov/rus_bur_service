import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:rus_bur_service/helpers/file_provider.dart';
import 'package:rus_bur_service/models/report.dart';
import 'package:pdf/widgets.dart';



class PdfProvider {
  Future<File> generate(Report report) async {
    var dataFont = await rootBundle.load("assets/fonts/font.ttf");
    var myFont = Font.ttf(dataFont);
    ByteData data = await rootBundle.load('assets/images/logo.png');
    final buffer = data.buffer;
    final pdf = Document();
    pdf.addPage(MultiPage(
        build: (context) => [
          buildLogo(buffer.asUint8List()),
          buildHeaderInfo('info'),
          buildHeaderInfo('info'),
          buildTitle(report),
        ]
    ));
    File _file = await FileProvider().savePdf(name: 'my_pdf.pdf', pdf: pdf);
    return _file;
  }

  static Widget buildLogo(Uint8List bytes) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
          height: 150.0,
          child: Image(MemoryImage(bytes),
          ))
    ]
  );

  static Widget buildHeaderInfo(String str) => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(str)
      ]
  );

  static Widget buildTitle(Report report) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
          'Report',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, font: Font.courier()),
      ),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
      Text(report.name),
    ]
  );
}