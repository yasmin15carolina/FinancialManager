import 'dart:io';
import 'dart:convert';
import 'package:finantial_manager/Saida/saida.dart';
import 'package:finantial_manager/Saida/saida_controller.dart';
import 'package:open_filex/open_filex.dart';
// ignore: unused_import
import 'package:path_provider/path_provider.dart';

class SaidaBackup {
  static Future<File> _getFile() async {
    //final directory = await getApplicationDocumentsDirectory();
    Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
    return File("${generalDownloadDir.path}/saidas-backup.txt");
  }

  static openFile() async {
    Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
    OpenFilex.open("${generalDownloadDir.path}/saidas-backup.txt");
  }

  static Future<File> saveFile() async {
    String data = "";

    List<Saida> saidas = await SaidaController.readAll();

    for (var s in saidas) {
      data += ' ${jsonEncode(s.toJson())};';
    }

    final file = await _getFile();
    return file.writeAsString(data);
  }

  static Future<String?> readFile() async {
    try {
      final file = await _getFile();
      var isExist = await file.exists();
      if (isExist) {
        return file.readAsString();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static deleteFileLogin() async {
    try {
      final file = await _getFile();
      var isExist = await file.exists();
      if (isExist) {
        file.delete();
      }
    } catch (e) {
      return null;
    }
  }
}
