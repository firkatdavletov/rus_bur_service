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
import 'package:rus_bur_service/models/user.dart';
import '../main.dart';



class PdfProvider {
  Future<File> generate(Report report, User user) async {
    print('PdfProvider is started');
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
          buildHeaderInfo('ООО «РусБурСервис»', _myFont),
          buildHeaderInfo('ИНН 6670196984, КПП 667001001', _myFont),
          SizedBox(height: 1.6 * PdfPageFormat.cm),
          buildTitle(report, titleStyle),
          SizedBox(height: 1.6 * PdfPageFormat.cm),
          buildSubtitle(report, user, styles)
        ]
    ));
    print('PDF provider: page 1 is created');
    pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          buildLogo(buffer.asUint8List(), 50.0),
          SizedBox(height: 1.6 * PdfPageFormat.cm),
          buildTable(report, tableStyle, tableHeaderStyle)
        ]
    ));
    print('PDF provider: page 2 is created');
    pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          buildLogo(buffer.asUint8List(), 50.0),
          SizedBox(height: 1.6 * PdfPageFormat.cm),
          buildTitlePage('СОГЛАСОВАННЫЕ НАПРАВЛЕНИЯ ДИАГНОСТИКИ', styles[0]),
          SizedBox(height: 1.6 * PdfPageFormat.cm),
          buildTable2(partsData, tableStyle, tableHeaderStyle)
        ]
    ));
    print('PDF provider: page 3 is created');
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
      print('PDF provider: page 4 is created');
    }

    final List<DiagnosticCard> _importantCards = await db.getCards(report.id, 3);
    final _importantCardsList = _importantCards.map((item) {
      return [
        '${item.id}',
        '${item.part.replaceAll('ё', 'е')}',
        '${item.description.replaceAll('ё', 'е')}',
        '${item.recommend.replaceAll('ё', 'е')}',
        '${item.effect.replaceAll('ё', 'е')}',
        '${item.manHours}'
      ];
    }).toList();
    final List<DiagnosticCard> _plannedCards = await db.getCards(report.id, 2);
    final _plannedCardsList = _plannedCards.map((item) {
      return [
        '${item.id}',
        '${item.part.replaceAll('ё', 'е')}',
        '${item.description.replaceAll('ё', 'е')}',
        '${item.recommend.replaceAll('ё', 'е')}',
        '${item.effect.replaceAll('ё', 'е')}',
        '${item.manHours}'
      ];
    }).toList();
    final List<DiagnosticCard> _recommendCards = await db.getCards(report.id, 1);
    final _recommendCardsList = _recommendCards.map((item) {
      return [
        '${item.id}',
        '${item.part.replaceAll('ё', 'е')}',
        '${item.description.replaceAll('ё', 'е')}',
        '${item.recommend.replaceAll('ё', 'е')}',
        '${item.effect.replaceAll('ё', 'е')}',
        '${item.manHours}'
      ];
    }).toList();
    pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.landscape,
        build: (context) => [
          buildLogo(buffer.asUint8List(), 50.0),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          buildTitlePage('РЕКОМЕНДУЕМЫЕ МЕРОПРИЯТИЯ ПО РЕЗУЛЬТАТАМ ПРОВЕРКИ', styles[0]),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          Text('ПРИОРИТЕТ - ВАЖНО', style: tableHeaderStyle),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          buildTable3(_importantCardsList, tableHeaderStyle2, tableStyle2),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          Text('ПРИОРИТЕТ - ПЛАНОВО', style: tableHeaderStyle),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          buildTable3(_plannedCardsList, tableHeaderStyle2, tableStyle2),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          Text('ПРИОРИТЕТ - РЕКОМЕНДАЦИИ, ПРЕДЛОЖЕНИЯ ПО УЛУЧШЕНИЮ, МОДЕРНИЗАЦИИ ОБОРУДОВАНИЯ', style: tableHeaderStyle),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          buildTable3(_recommendCardsList, tableHeaderStyle2, tableStyle2)
        ]
    ));
    print('PDF provider: page 5 is created');

    final List<Spare> _importantSpares = await db.getSparesReport(report.id, 3);
    final _importantSparesList = _importantSpares.map((item) {
      return [
        '${item.cardId}',
        '${item.number}',
        '${item.name.replaceAll('ё', 'е')}',
        '${item.quantity}',
        '${item.measure.replaceAll('ё', 'е')}',
        '${item.part.replaceAll('ё', 'е')}',
        '${item.issue.replaceAll('ё', 'е')}',
      ];
    }).toList();
    final List<Spare> _plannedSpares = await db.getSparesReport(report.id, 2);
    final _plannedSparesList = _plannedSpares.map((item) {
      return [
        '${item.cardId}',
        '${item.number}',
        '${item.name.replaceAll('ё', 'е')}',
        '${item.quantity}',
        '${item.measure.replaceAll('ё', 'е')}',
        '${item.part.replaceAll('ё', 'е')}',
        '${item.issue.replaceAll('ё', 'е')}',
      ];
    }).toList();
    final List<Spare> _recommendSpares = await db.getSparesReport(report.id, 1);
    final _recommendSparesList = _recommendSpares.map((item) {
      return [
        '${item.cardId}',
        '${item.number}',
        '${item.name.replaceAll('ё', 'е')}',
        '${item.quantity}',
        '${item.measure.replaceAll('ё', 'е')}',
        '${item.part.replaceAll('ё', 'е')}',
        '${item.issue.replaceAll('ё', 'е')}',
      ];
    }).toList();

    pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.landscape,
        build: (context) => [
          buildLogo(buffer.asUint8List(), 50.0),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          buildTitlePage('ПЕРЕЧЕНЬ НЕОБХОДИМЫХ ЗАПЧАСТЕЙ', styles[0]),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          Text('ПРИОРИТЕТ - ВАЖНО', style: tableHeaderStyle),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          buildTable4(_importantSparesList, tableHeaderStyle2, tableStyle2),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          Text('ПРИОРИТЕТ - ПЛАНОВО', style: tableHeaderStyle),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          buildTable4(_plannedSparesList, tableHeaderStyle2, tableStyle2),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          Text('ПРИОРИТЕТ - РЕКОМЕНДАЦИИ, ПРЕДЛОЖЕНИЯ ПО УЛУЧШЕНИЮ, МОДЕРНИЗАЦИИ ОБОРУДОВАНИЯ', style: tableHeaderStyle),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          buildTable4(_recommendSparesList, tableHeaderStyle2, tableStyle2)
        ]
    ));
    print('PDF provider: page 6 is created');
    final List<DiagnosticCard> allCards = await db.getAllCards(report.id);
    for (DiagnosticCard dc in allCards) {
      final _cardImages = await db.getPicture(report.id, dc.id);
      final _cardPicturesWidgets = _cardImages.map((item) => Column(
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
      final List<Spare> _spares = await db.getSpare(dc.id);
      pdf.addPage(MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) => [
            buildLogo(buffer.asUint8List(), 50.0),
            SizedBox(height: 0.4 * PdfPageFormat.cm),
            buildTitlePage('ДИАГНОСТИЧЕСКАЯ КАРТА ${dc.id}', styles[0]),
            SizedBox(height: 0.4 * PdfPageFormat.cm),
            buildTable5(dc, tableStyle),
            SizedBox(height: 0.4 * PdfPageFormat.cm),
            buildTitlePage('ПЕРЕЧЕНЬ НЕОБХОДИМЫХ ЗАПЧАСТЕЙ', tableHeaderStyle2),
            SizedBox(height: 0.4 * PdfPageFormat.cm),
            buildTable6(_spares, tableStyle2, tableHeaderStyle2),
            SizedBox(height: 0.4 * PdfPageFormat.cm),
            buildPicturesList(_cardPicturesWidgets)
          ]
      ));
      print('PDF provider: page 7 is created');
    }
    print('PDF provider: start save pdf');
    final File _file = await FileProvider().savePdf(name: ' Отчет ${report.name}.pdf', pdf: pdf);
    return _file;
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

  static Widget buildTitle(Report report, TextStyle style) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
          'ОТЧЕТ ПО РЕЗУЛЬТАТАМ',
          style: style,
      ),
      SizedBox(height: 0.2 * PdfPageFormat.cm),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              'ДИАГНОСТИКИ БУРОВОГО СТАНКА',
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

  static Widget buildSubtitle(Report report, User user, List<TextStyle> styles) => Column(
    children: [
      Row(
        children: [
          Text('Заказчик:', style: styles[0]),
          SizedBox(width: 0.2 * PdfPageFormat.cm),
          Text('${report.company.replaceAll('ё', 'е')}', style: styles[1])
        ]
      ),
      SizedBox(height: 2.4 * PdfPageFormat.cm),
      Row(
          children: [
            Text('Дата осмотра:', style: styles[0]),
            SizedBox(width: 0.2 * PdfPageFormat.cm),
            Text('${report.date}', style: styles[1])
          ]
      ),
      Row(
          children: [
            Text('Исполнитель:', style: styles[0]),
            SizedBox(width: 0.2 * PdfPageFormat.cm),
            Text('ООО "РусБурСервис"', style: styles[1])
          ]
      ),
      SizedBox(height: 0.8 * PdfPageFormat.cm),
      Row(
          children: [
            Text('Сервисный инженер:', style: styles[1]),
            SizedBox(width: 0.2 * PdfPageFormat.cm),
            Text('${user.firstName.replaceAll('ё', 'е')} '
                '${user.lastName.replaceAll('ё', 'е')} '
                '${user.middleName.replaceAll('ё', 'е')}',
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
    headers: ['Заказчик', '${report.company.replaceAll('ё', 'е')}'],
    data: [
      ['Место проведения\nработ', '${report.place.replaceAll('ё', 'е')}'],
      ['Контактное лицо\nзаказчика', '${report.customerName.replaceAll('ё', 'е')}'],
      ['Модель машины', '${report.machineModel.replaceAll('ё', 'е')}'],
      ['Серийный номер\nмашины', '${report.machineNumb}'],
      ['Год выпуска', '${report.machineYear}'],
      ['Модель двигателя', '${report.engineModel.replaceAll('ё', 'е')}'],
      ['Серийный номер\nдвигателя', '${report.engineNumb}'],
      ['Наработка', '${report.opTime_1} м/ч\n'
          '${report.opTime_2} уд/ч\n'
          '${report.opTime_3} пог.м'],
      ['Примечание', '${report.note.replaceAll('ё', 'е')}']
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
      headers: ['Узел/система', 'Да', 'Нет'],
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
        'Номер диагностической карты',
        'Узел/система',
        'Описание проблемы',
        'Решение',
        'Риски, положительный эффект',
        'Кол-во чел/часов (плановое)'
      ],
      columnWidths: {
        0 : FlexColumnWidth(),
        1 : FlexColumnWidth(),
        2 : FlexColumnWidth(),
        3 : FlexColumnWidth(),
        4 : FlexColumnWidth(),
        5 : FixedColumnWidth(75.0),
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
        'Номер диагностической карты',
        'Каталожный номер',
        'Наименование',
        'Кол-во',
        'Единица измерения',
        'Узел/система',
        'Проблема',
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
    BoxDecoration _dec(int i, dynamic data, int j) {
      if (i == 0) {
        return BoxDecoration(color: PdfColors.grey300);
      } else {
        return BoxDecoration();
      }

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
          ['Описание диагностической операции', '${dc.name}'],
          ['Заключение по результатам проверки', dc.conclusion == 1
              ? 'УСПЕШНО'
              : dc.conclusion == 2
              ? 'ВНИМАНИЕ'
              : 'НЕУДАЧА'],
          ['Описание проблемы', '${dc.description.replaceAll('ё', 'е')}'],
          ['Узел/система', '${dc.part.replaceAll('ё', 'е')}'],
          ['Зона выявления дефекта', '${dc.area.replaceAll('ё', 'е')}'],
          ['Вид повреждения', '${dc.damage.replaceAll('ё', 'е')}'],
          ['Приоритетность решения выявленной проблемы', dc.priority == 1
              ? 'РЕКОМЕНДУЕТСЯ'
              : dc.conclusion == 2
              ? 'ПЛАНОВО'
              : 'СРОЧНО'],
          ['Рекомендуемое решение', '${dc.recommend.replaceAll('ё', 'е')}'],
          ['Срок на реализацию', '${dc.time}'],
          ['Риски, положительный эффект', '${dc.effect.replaceAll('ё', 'е')}'],
          ['Кол-во чел/ч на ремонт (планово)', '${dc.manHours}']
        ]
    );
  }
  static buildTable6(List<Spare> spares, TextStyle cellStyle, TextStyle headerStyle) {
    var _sparesList = spares.map((item) {
      return [
        '${item.number}',
        '${item.name.replaceAll('ё', 'е')}',
        '${item.quantity}',
        '${item.measure.replaceAll('ё', 'е')}',
        '${item.issue.replaceAll('ё', 'е')}',
        '${item.priority}'
      ];
    }).toList();
    return Table.fromTextArray(
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      headers: [
        'Каталожный номер',
        'Наименование',
        'Кол-во',
        'Ед. изм.',
        'Проблема',
        'Приоритет '
      ],
      headerStyle: headerStyle,
      data: _sparesList,
      cellStyle: cellStyle
    );
  }
}