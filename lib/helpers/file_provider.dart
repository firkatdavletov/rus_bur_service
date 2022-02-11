import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class FileProvider {

  ///To save the Excel file in the device
  Future<void> save(List<int> bytes, String fileName) async {
    String? path = await _getPath();
    final File file = File('$path/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    //await open_file.OpenFile.open('$path/$fileName');
  }

  Future<File> savePdf({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    String? path = await _getPath();
    final file = File('$path/$name');

    file.writeAsBytesSync(bytes);
    return file;
  }

  Future<void> delete(String fileName) async {
    String? path = await _getPath();
    File('$path/$fileName').delete();
  }

  // Future<File> getFile(String fileName) async {
  //   return F
  // }

  Future<String?> _getPath() async {
    String? path;
    final Directory directory = await getApplicationSupportDirectory();
    path = directory.path;
    return path;
  }
}