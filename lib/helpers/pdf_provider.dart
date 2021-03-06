import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:rus_bur_service/helpers/file_provider.dart';
import 'package:rus_bur_service/models/diagnostic_card.dart';
import 'package:rus_bur_service/models/part.dart';
import 'package:rus_bur_service/models/report.dart';
import 'package:pdf/widgets.dart';
import 'package:rus_bur_service/models/spare.dart';
import 'package:rus_bur_service/models/status.dart';
import 'package:rus_bur_service/models/user.dart';
import '../main.dart';



class PdfProvider {

  Future<bool> generate(Report report, User user) async {


    if (report.machineModel.isEmpty || report.machineModel.length < 1
        || report.machineYear.isEmpty || report.machineYear.length < 1
        || report.machineNumb.isEmpty || report.machineNumb.length < 1) {
      return false;
    }

    Status status = Status();

    final _dataFont = await rootBundle.load("assets/fonts/font.ttf");
    final _myFont = Font.ttf(_dataFont);
    final TextStyle titleStyle = TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        font: _myFont
    );
    final TextStyle tableStyle = TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.normal,
        font: _myFont
    );
    final TextStyle tableStyle2 = TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.normal,
        font: _myFont
    );
    final TextStyle tableHeaderStyle = TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
        font: _myFont
    );
    final TextStyle tableHeaderStyle2 = TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.bold,
        font: _myFont
    );
    final List<TextStyle> styles = [
      TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          font: _myFont
      ),
      TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          font: _myFont
      ),
    ];

    final ByteData data = await rootBundle.load('assets/images/logo.png');
    final buffer = data.buffer;

    final List<Part> _parts = await db.getPartsWithAgreedParts(report.id);
    if (_parts.isEmpty) {
      return false;
    }
    final partsData = _parts.map((item) {
      return [
        '${item.name}',
        item.isChecked
            ? 'X'
            : '',
        item.isChecked
            ? ''
            : 'X'
      ];
    }).toList();

    final pdf = Document();
    pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat.a4,
        build: (context) => [
          buildLogo(buffer.asUint8List(), 150.0),
          buildHeaderInfo('?????? ????????????????????????????', _myFont),
          buildHeaderInfo('?????? 6670196984, ?????? 667001001', _myFont),
          SizedBox(height: 1.6 * PdfPageFormat.cm),
          buildTitle(report, titleStyle),
          SizedBox(height: 1.6 * PdfPageFormat.cm),
          buildSubtitle(report, user, styles)
        ]
    ));

    pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          buildLogo(buffer.asUint8List(), 50.0),
          SizedBox(height: 1.6 * PdfPageFormat.cm),
          buildTable(report, tableStyle, tableHeaderStyle)
        ]
    ));

    pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          buildLogo(buffer.asUint8List(), 50.0),
          SizedBox(height: 1.6 * PdfPageFormat.cm),
          buildTitlePage('?????????????????????????? ?????????????????????? ??????????????????????', styles[0]),
          SizedBox(height: 1.6 * PdfPageFormat.cm),
          buildTable2(partsData, tableStyle, tableHeaderStyle)
        ]
    ));
    final _images = await db.getPicture(report.id, '');
    final String? path;
    final Directory directory = await getApplicationSupportDirectory();
    path = directory.path;
    final _pictureWidgets = _images.map((item) => Column(
      children: [
        Text('${item.name}', style: tableStyle),
        SizedBox(height: 0.4 * PdfPageFormat.cm),
        Image(
            MemoryImage(File('$path/${item.pictureFileName}.jpg').readAsBytesSync()),
            width: 200.0,
        ),
        Text('${item.description}', style: tableStyle)
      ]
    )).toList();
    if (_pictureWidgets.length != 0) {
      pdf.addPage(MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) => [
            buildPicturesList(_pictureWidgets)
          ]
      ));
    }

    final List<DiagnosticCard> _importantCards = await db.getCards(report.id, 3);

    final _importantCardsList = _importantCards.map((item) {
      String _name;
      int i = item.id.indexOf('-');
      _name = item.id.substring(i+1);

      String recommend = '';
      if (item.status&status.status6 == status.status6) {
        recommend += '????????????;\n';
      }
      if (item.status&status.status7 == status.status7) {
        recommend += '????????????;\n';
      }
      if (item.status&status.status8 == status.status8) {
        recommend += '??????????????????;\n';
      }
      if (item.status&status.status9 == status.status9) {
        recommend += '??????????????????????;\n';
      }
      if (item.status&status.status10 == status.status10) {
        recommend += '??????????????;\n';
      }
      if (item.recommend.length > 0) {
        recommend += '${item.recommend.replaceAll('??', '??')}';
      }

      String effect = '';

      if (item.status&status.status11 == status.status11) {
        effect += '???????????????? ????????????????;\n';
      }
      if (item.status&status.status12 == status.status12) {
        effect += '???????????????????????? ????????????????????;\n';
      }
      if (item.status&status.status13 == status.status13) {
        effect += '???????????????????????????????? ????????????????????????;\n';
      }
      if (item.status&status.status14 == status.status14) {
        effect += '???????????????????? ?????????????? ??????????????;\n';
      }
      if (item.status&status.status15 == status.status15) {
        effect += '???????????????????????? ????????????????????????;\n';
      }
      if (item.effect.length > 0) {
        effect += '${item.effect.replaceAll('??', '??')}';
      }


      return [
        '$_name',
        '${item.part.replaceAll('??', '??')}',
        '${item.description.replaceAll('??', '??')}',
        '${recommend.replaceAll('??', '??')}',
        '${effect.replaceAll('??', '??')}',
        '${item.manHours} ??????.-??????.'
      ];
    }).toList();
    final List<DiagnosticCard> _plannedCards = await db.getCards(report.id, 2);
    final _plannedCardsList = _plannedCards.map((item) {
      String _name;
      int i = item.id.indexOf('-');
      _name = item.id.substring(i+1);

      String recommend = '';

      if (item.status&status.status6 == status.status6) {
        recommend += '????????????;\n';
      }
      if (item.status&status.status7 == status.status7) {
        recommend += '????????????;\n';
      }
      if (item.status&status.status8 == status.status8) {
        recommend += '??????????????????;\n';
      }
      if (item.status&status.status9 == status.status9) {
        recommend += '??????????????????????;\n';
      }
      if (item.status&status.status10 == status.status10) {
        recommend += '??????????????;\n';
      }
      if (item.recommend.length > 0) {
        recommend += '${item.recommend.replaceAll('??', '??')}';
      }

      String effect = '';
      if (item.status&status.status11 == status.status11) {
        effect += '???????????????? ????????????????;\n';
      }
      if (item.status&status.status12 == status.status12) {
        effect += '???????????????????????? ????????????????????;\n';
      }
      if (item.status&status.status13 == status.status13) {
        effect += '???????????????????????????????? ????????????????????????;\n';
      }
      if (item.status&status.status14 == status.status14) {
        effect += '???????????????????? ?????????????? ??????????????;\n';
      }
      if (item.status&status.status15 == status.status15) {
        effect += '???????????????????????? ????????????????????????;\n';
      }
      if (item.effect.length > 0) {
        effect += '${item.effect.replaceAll('??', '??')}';
      }

      return [
        '$_name',
        '${item.part.replaceAll('??', '??')}',
        '${item.description.replaceAll('??', '??')}',
        '${recommend.replaceAll('??', '??')}',
        '${effect.replaceAll('??', '??')}',
        '${item.manHours} ??????.-??????.'
      ];
    }).toList();
    final List<DiagnosticCard> _recommendCards = await db.getCards(report.id, 1);
    final _recommendCardsList = _recommendCards.map((item) {
      String _name;
      int i = item.id.indexOf('-');
      _name = item.id.substring(i+1);

      String recommend = '';

      if (item.status&status.status6 == status.status6) {
        recommend += '????????????;\n';
      }
      if (item.status&status.status7 == status.status7) {
        recommend += '????????????;\n';
      }
      if (item.status&status.status8 == status.status8) {
        recommend += '??????????????????;\n';
      }
      if (item.status&status.status9 == status.status9) {
        recommend += '??????????????????????;\n';
      }
      if (item.status&status.status10 == status.status10) {
        recommend += '??????????????;\n';
      }
      if (item.recommend.length > 0) {
        recommend += '${item.recommend.replaceAll('??', '??')}';
      }

      String effect = '';

      if (item.status&status.status11 == status.status11) {
        effect += '???????????????? ????????????????;\n';
      }
      if (item.status&status.status12 == status.status12) {
        effect += '???????????????????????? ????????????????????\n';
      }
      if (item.status&status.status13 == status.status13) {
        effect += '???????????????????????????????? ????????????????????????\n';
      }
      if (item.status&status.status14 == status.status14) {
        effect += '???????????????????? ?????????????? ??????????????\n';
      }
      if (item.status&status.status15 == status.status15) {
        effect += '???????????????????????? ????????????????????????\n';
      }
      if (item.effect.length > 0) {
        effect += '${item.effect.replaceAll('??', '??')}';
      }

      return [
        '$_name',
        '${item.part.replaceAll('??', '??')}',
        '${item.description.replaceAll('??', '??')}',
        '${recommend.replaceAll('??', '??')}',
        '${effect.replaceAll('??', '??')}',
        '${item.manHours} ??????.-??????.'
      ];
    }).toList();
    pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.landscape,
        build: (context) => [
          buildLogo(buffer.asUint8List(), 50.0),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          buildTitlePage('?????????????????????????? ?????????????????????? ???? ?????????????????????? ????????????????', styles[0]),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          _importantCardsList.isNotEmpty
              ? Text('?????????????????? - ??????????', style: tableHeaderStyle)
              : SizedBox(height: 0.1 * PdfPageFormat.cm),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          _importantCardsList.isNotEmpty
            ? buildTable3(_importantCardsList, tableHeaderStyle2, tableStyle2)
            : SizedBox(height: 0.1 * PdfPageFormat.cm),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          _plannedCardsList.isNotEmpty
              ? Text('?????????????????? - ??????????????', style: tableHeaderStyle)
              : SizedBox(height: 0.1 * PdfPageFormat.cm),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          _plannedCardsList.isNotEmpty
              ? buildTable3(_plannedCardsList, tableHeaderStyle2, tableStyle2)
              : SizedBox(height: 0.1 * PdfPageFormat.cm),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          _recommendCardsList.isNotEmpty
              ? Text('?????????????????? - ????????????????????????, ?????????????????????? ???? ??????????????????, ???????????????????????? ????????????????????????', style: tableHeaderStyle)
              : SizedBox(height: 0.1 * PdfPageFormat.cm),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          _recommendCardsList.isNotEmpty
              ? buildTable3(_recommendCardsList, tableHeaderStyle2, tableStyle2)
              : SizedBox(height: 0.1 * PdfPageFormat.cm)
        ]
    ));

    final List<Spare> _importantSpares = await db.getSparesReport(report.id, 3);
    final _importantSparesList = _importantSpares.map((item) {
      String _name;
      int i = item.cardId.indexOf('-');
      _name = item.cardId.substring(i+1);
      return [
        '$_name',
        '${item.number}',
        '${item.name.replaceAll('??', '??')}',
        '${item.quantity}',
        '${item.measure.replaceAll('??', '??')}',
        '${item.part.replaceAll('??', '??')}',
        '${item.issue.replaceAll('??', '??')}',
      ];
    }).toList();
    final List<Spare> _plannedSpares = await db.getSparesReport(report.id, 2);
    final _plannedSparesList = _plannedSpares.map((item) {
      String _name;
      int i = item.cardId.indexOf('-');
      _name = item.cardId.substring(i+1);
      return [
        '$_name',
        '${item.number}',
        '${item.name.replaceAll('??', '??')}',
        '${item.quantity}',
        '${item.measure.replaceAll('??', '??')}',
        '${item.part.replaceAll('??', '??')}',
        '${item.issue.replaceAll('??', '??')}',
      ];
    }).toList();
    final List<Spare> _recommendSpares = await db.getSparesReport(report.id, 1);
    final _recommendSparesList = _recommendSpares.map((item) {
      String _name;
      int i = item.cardId.indexOf('-');
      _name = item.cardId.substring(i+1);
      return [
        '$_name',
        '${item.number}',
        '${item.name.replaceAll('??', '??')}',
        '${item.quantity}',
        '${item.measure.replaceAll('??', '??')}',
        '${item.part.replaceAll('??', '??')}',
        '${item.issue.replaceAll('??', '??')}',
      ];
    }).toList();

    pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.landscape,
        build: (context) => [
          buildLogo(buffer.asUint8List(), 50.0),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          buildTitlePage('???????????????? ?????????????????????? ??????????????????', styles[0]),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          _importantSparesList.isNotEmpty
              ? Text('?????????????????? - ??????????', style: tableHeaderStyle)
              : SizedBox(height: 0.1 * PdfPageFormat.cm),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          _importantSparesList.isNotEmpty
              ? buildTable4(_importantSparesList, tableHeaderStyle2, tableStyle2)
              : SizedBox(height: 0.1 * PdfPageFormat.cm),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          _plannedSparesList.isNotEmpty
              ? Text('?????????????????? - ??????????????', style: tableHeaderStyle)
              : SizedBox(height: 0.1 * PdfPageFormat.cm),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          _plannedSparesList.isNotEmpty
              ? buildTable4(_plannedSparesList, tableHeaderStyle2, tableStyle2)
              : SizedBox(height: 0.1 * PdfPageFormat.cm),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          _recommendSparesList.isNotEmpty
              ? Text('?????????????????? - ????????????????????????, ?????????????????????? ???? ??????????????????, ???????????????????????? ????????????????????????', style: tableHeaderStyle)
              : SizedBox(height: 0.1 * PdfPageFormat.cm),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          _recommendSparesList.isNotEmpty
              ? buildTable4(_recommendSparesList, tableHeaderStyle2, tableStyle2)
              : SizedBox(height: 0.1 * PdfPageFormat.cm)
        ]
    ));

    final List<DiagnosticCard> allCards = await db.getAllCards(report.id);
    if (allCards.isEmpty) {
      return false;
    }
    for (DiagnosticCard dc in allCards) {

      if (dc.conclusion != 1
          && (dc.description == ''
              || dc.area == ''
              || dc.damage == ''
                  && dc.status&status.status1 != status.status1
                  && dc.status&status.status2 != status.status2
                  && dc.status&status.status3 != status.status3
                  && dc.status&status.status4 != status.status4
                  && dc.status&status.status5 != status.status5)) {
        return false;
      } else if (dc.effect == ''
          && dc.status&status.status6 != status.status6
          && dc.status&status.status7 != status.status7
          && dc.status&status.status8 != status.status8
          && dc.status&status.status9 != status.status9
          && dc.status&status.status10 != status.status10) {
        return false;
      } else if (dc.recommend == ''
          && dc.status&status.status11 != status.status11
          && dc.status&status.status12 != status.status12
          && dc.status&status.status13 != status.status13
          && dc.status&status.status14 != status.status14
          && dc.status&status.status15 != status.status15) {
        return false;
      }

      String _name;
      int i = dc.id.indexOf('-');
      _name = dc.id.substring(i+1);
      final _cardImages = await db.getPicture(report.id, dc.id);
      final _cardPicturesWidgets = _cardImages.map((item) => Column(
          children: [
            Text('$_name', style: tableStyle),
            SizedBox(height: 0.4 * PdfPageFormat.cm),
            Image(
              MemoryImage(File('$path/${item.pictureFileName}.jpg').readAsBytesSync()),
              width: 200.0,
            ),
            Text('${item.description}', style: tableStyle)
          ]
      )).toList();
      final List<Spare> _spares = await db.getSpare(dc.id);
      pdf.addPage(MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) => [
            buildLogo(buffer.asUint8List(), 50.0),
            SizedBox(height: 0.4 * PdfPageFormat.cm),
            buildTitlePage('?????????????????????????????? ?????????? $_name', styles[0]),
            SizedBox(height: 0.4 * PdfPageFormat.cm),
            buildTable5(dc, tableStyle),
          ]
      ));
      if (_spares.isNotEmpty) {
        pdf.addPage(MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) => [
            buildLogo(buffer.asUint8List(), 50.0),
            SizedBox(height: 0.4 * PdfPageFormat.cm),
            buildTitlePage('???????????????? ?????????????????????? ??????????????????', tableHeaderStyle2),
            SizedBox(height: 0.4 * PdfPageFormat.cm),
            buildTable6(_spares, tableStyle2, tableHeaderStyle2),
            SizedBox(height: 0.4 * PdfPageFormat.cm),
            buildPicturesList(_cardPicturesWidgets)
          ]
        ));
      }
      if (_cardPicturesWidgets.isNotEmpty) {
        pdf.addPage(MultiPage(
            pageFormat: PdfPageFormat.a4,
            build: (context) => [
              buildLogo(buffer.asUint8List(), 50.0),
              SizedBox(height: 0.4 * PdfPageFormat.cm),
              buildPicturesList(_cardPicturesWidgets)
            ]
        ));
      }
    }
    FileProvider().savePdf(name: 'report_pdf.pdf', pdf: pdf);
    return true;
  }

  static Widget buildLogo(Uint8List bytes, double height) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
          height: height,
          child: Image(MemoryImage(bytes),
          ))
    ]
  );

  static Widget buildHeaderInfo(String str, Font font) => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(str, style: TextStyle(font: font, fontSize: 12.0))
      ]
  );

  static Widget buildTitle(Report report, TextStyle style) {
    return Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '?????????? ???? ??????????????????????',
            style: style,
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    '?????????????????????? ???????????????? ????????????',
                    style: style
                )
              ]
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Text(
              '${report.name}',
              style: style
          )
        ]
    );
  }

  static Widget buildSubtitle(Report report, User user, List<TextStyle> styles) => Column(
    children: [
      Row(
        children: [
          Text('????????????????:', style: styles[0]),
          SizedBox(width: 0.2 * PdfPageFormat.cm),
          Text('${report.company.replaceAll('??', '??')}', style: styles[1])
        ]
      ),
      SizedBox(height: 2.4 * PdfPageFormat.cm),
      Row(
          children: [
            Text('???????? ??????????????:', style: styles[0]),
            SizedBox(width: 0.2 * PdfPageFormat.cm),
            Text('${report.date}', style: styles[1])
          ]
      ),
      Row(
          children: [
            Text('??????????????????????:', style: styles[0]),
            SizedBox(width: 0.2 * PdfPageFormat.cm),
            Text('?????? "????????????????????????"', style: styles[1])
          ]
      ),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
      Row(
          children: [
            Text('?????????????????? ??????????????:', style: styles[1]),
            SizedBox(width: 0.2 * PdfPageFormat.cm),
            Text('${user.firstName.replaceAll('??', '??')} '
                '${user.lastName.replaceAll('??', '??')} '
                '${user.middleName.replaceAll('??', '??')}',
                style: styles[1])
          ]
      )
    ]
  );
  static Widget buildTable(Report report, TextStyle cellStyle, TextStyle headerStyle) => Table.fromTextArray(
    headerStyle: headerStyle,
    cellStyle: cellStyle,
    columnWidths: {
      0 : FixedColumnWidth(150.0),
      1 : FlexColumnWidth()
    },
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
    headers: ['????????????????', '${report.company.replaceAll('??', '??')}'],
    data: [
      ['?????????? ????????????????????\n??????????', '${report.place.replaceAll('??', '??')}'],
      ['???????????????????? ????????\n??????????????????', '${report.customerName.replaceAll('??', '??')}'],
      ['???????????? ????????????', '${report.machineModel.replaceAll('??', '??')}'],
      ['???????????????? ??????????\n????????????', '${report.machineNumb}'],
      ['?????? ??????????????', '${report.machineYear}'],
      ['???????????? ??????????????????', '${report.engineModel.replaceAll('??', '??')}'],
      ['???????????????? ??????????\n??????????????????', '${report.engineNumb}'],
      report.opTime_1 != 0? ['?????????????????? ??????????????????', '${report.opTime_1} ??/??'] : [],
      report.opTime_2 != 0? ['?????????????????? ??????????????????', '${report.opTime_2} ????/??'] : [],
      report.opTime_3 != 0? ['?????????????????? ?? ?????????????? ????????????', '${report.opTime_3} ??????.??'] : [],
      report.opTime_4 != 0? ['?????????????????? ?????????????????????? ??????????????????', '${report.opTime_4} ??/??'] : [],
      ['????????????????????', '${report.note.replaceAll('??', '??')}']
    ]
  );
  static Widget buildTitlePage(String text, TextStyle style) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text, style: style)
    ]
  );
  static buildTable2(List<List<String>> parts, TextStyle cellStyle, TextStyle headerStyle) => Table.fromTextArray(
      headerStyle: headerStyle,
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      columnWidths: {
        0 : FlexColumnWidth(),
        1 : FixedColumnWidth(50.0),
        2 : FixedColumnWidth(50.0)
      },
      cellAlignments: {
        0 : Alignment.centerLeft,
        1 : Alignment.center,
        2 : Alignment.center
      },
      cellStyle: cellStyle,
      headers: ['????????/??????????????', '????', '??????'],
      data: parts
  );
  static buildPicturesList(List<Widget> widgets) => GridView(
    childAspectRatio: 1.3,
    crossAxisCount: 2,
    children: widgets,
  );
  static buildTable3(
      List<List<String>> data,
      TextStyle headerStyle,
      TextStyle cellStyle
      ) => Table.fromTextArray(
      headerStyle: headerStyle,
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      headers: [
        '?????????? ?????????????????????????????? ??????????',
        '????????/??????????????',
        '???????????????? ????????????????',
        '??????????????',
        '??????????, ?????????????????????????? ????????????',
        '???????????????????????? (????????????????)'
      ],
      columnWidths: {
        0 : FlexColumnWidth(),
        1 : FlexColumnWidth(),
        2 : FlexColumnWidth(),
        3 : FlexColumnWidth(),
        4 : FlexColumnWidth(),
        5 : FixedColumnWidth(85.0),
      },
      cellStyle: cellStyle,
      data: data
  );
  static buildTable4(
      List<List<String>> data,
      TextStyle headerStyle,
      TextStyle cellStyle
      ) => Table.fromTextArray(
      headerStyle: headerStyle,
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      headers: [
        '?????????? ?????????????????????????????? ??????????',
        '???????????????????? ??????????',
        '????????????????????????',
        '??????-????',
        '?????????????? ??????????????????',
        '????????/??????????????',
        '????????????????',
      ],
      columnWidths: {
        0 : FlexColumnWidth(),
        1 : FlexColumnWidth(),
        2 : FlexColumnWidth(),
        3 : FlexColumnWidth(),
        4 : FlexColumnWidth(),
        5 : FlexColumnWidth(),
        6 : FlexColumnWidth(),
      },
      cellStyle: cellStyle,
      data: data
  );
  static buildTable5(DiagnosticCard dc, TextStyle cellStyle) {
    Status status = Status();
    BoxDecoration _dec(int i, dynamic data, int j) {
      if (i == 0) {
        return BoxDecoration(color: PdfColors.grey300);
      } else {
        return BoxDecoration();
      }

    }

    String damage = '';
    if (dc.status&status.status1 == status.status1) {
      damage += '??????????;\n';
    }
    if (dc.status&status.status2 == status.status2) {
      damage += '????????????????????;\n';
    }
    if (dc.status&status.status3 == status.status3) {
      damage += '???????????????? ????????????;\n';
    }
    if (dc.status&status.status4 == status.status4) {
      damage += '????????????????????????;\n';
    }
    if (dc.status&status.status5 == status.status5) {
      damage += '????????????????????????????;\n';
    }
    if (dc.damage.length > 0) {
      damage += '${dc.damage.replaceAll('??', '??')}';
    }

    String recommend = '';

    if (dc.status&status.status6 == status.status6) {
      recommend += '????????????;\n';
    }
    if (dc.status&status.status7 == status.status7) {
      recommend += '????????????;\n';
    }
    if (dc.status&status.status8 == status.status8) {
      recommend += '??????????????????;\n';
    }
    if (dc.status&status.status9 == status.status9) {
      recommend += '??????????????????????;\n';
    }
    if (dc.status&status.status10 == status.status10) {
      recommend += '??????????????;\n';
    }
    if (dc.recommend.length > 0) {
      recommend += '${dc.recommend.replaceAll('??', '??')}';
    }

    String effect = '';

    if (dc.status&status.status11 == status.status11) {
      effect += '???????????????? ????????????????;\n';
    }
    if (dc.status&status.status12 == status.status12) {
      effect += '???????????????????????? ????????????????????;\n';
    }
    if (dc.status&status.status13 == status.status13) {
      effect += '???????????????????????????????? ????????????????????????;\n';
    }
    if (dc.status&status.status14 == status.status14) {
      effect += '???????????????????? ?????????????? ??????????????;\n';
    }
    if (dc.status&status.status15 == status.status15) {
      effect += '???????????????????????? ????????????????????????\n';
    }
    if (dc.effect.length > 0) {
      effect += '${dc.effect.replaceAll('??', '??')}';
    }


    String _prefix;
    const termStatusType1 = ['????????', '????????????', '??????????'];
    const termStatusType2 = ['????????', '????????????', '??????????????'];
    const termStatusType3 = ['??????', '????????????', '????????????'];

    if (dc.termWeek%10 == 1) {
      _prefix = termStatusType1[dc.termStatus];
    } else if(dc.termWeek > 1 && dc.termWeek < 5) {
      _prefix = termStatusType3[dc.termStatus];
    } else {
      _prefix = termStatusType2[dc.termStatus];
    }

    String _term = '';

    if (dc.termWeek != 0) {
      _term += '${dc.termWeek} $_prefix\n';
    }
    if (dc.term_mh != 0) {
      _term += '${dc.term_mh} ??/??\n';
    }
    if (dc.term_bh != 0) {
      _term += '${dc.term_bh} ????./??\n';
    }
    if (dc.term_m != 0) {
      _term += '${dc.term_m} ??????. ??\n';
    }



    return Table.fromTextArray(
        cellStyle: cellStyle,
        headerCount: 0,
        headerStyle: cellStyle,
        headerAlignment: Alignment.centerLeft,
        columnWidths: {
          0 : FixedColumnWidth(160.0),
          1 : FlexColumnWidth()
        },
        cellDecoration: _dec,
        data: [
          ['???????????????? ?????????????????????????????? ????????????????', '${dc.name}'],
          ['???????????????????? ???? ?????????????????????? ????????????????', dc.conclusion == 1
              ? '??????????????'
              : dc.conclusion == 2
              ? '????????????????'
              : '??????????????'],
          dc.conclusion != 1? ['???????????????? ????????????????', '${dc.description.replaceAll('??', '??')}']: [],
          ['????????/??????????????', '${dc.part.replaceAll('??', '??')}'],
          dc.conclusion != 1? ['???????? ?????????????????? ??????????????', '${dc.area.replaceAll('??', '??')}']: [],
          dc.conclusion != 1? ['?????? ??????????????????????', damage]: [],
          ['???????????????????????????? ?????????????? ???????????????????? ????????????????', dc.priority == 1
              ? '??????????????????????????'
              : dc.conclusion == 2
              ? '??????????????'
              : '????????????'],
          ['?????????????????????????? ??????????????', recommend],
          ['???????? ???? ????????????????????', _term],
          ['??????????, ?????????????????????????? ????????????', effect],
          ['???????????????????????? (??????????????)', '${dc.manHours} ??????.-??????.']
        ]
    );
  }
  static buildTable6(List<Spare> spares, TextStyle cellStyle, TextStyle headerStyle) {
    var _sparesList = spares.map((item) {
      return [
        '${item.number}',
        '${item.name.replaceAll('??', '??')}',
        '${item.quantity}',
        '${item.measure.replaceAll('??', '??')}',
        '${item.issue.replaceAll('??', '??')}',
        '${item.priority}'
      ];
    }).toList();
    return Table.fromTextArray(
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      headers: [
        '???????????????????? ??????????',
        '????????????????????????',
        '??????-????',
        '????. ??????.',
        '????????????????',
        '?????????????????? '
      ],
      headerStyle: headerStyle,
      data: _sparesList,
      cellStyle: cellStyle
    );
  }
}