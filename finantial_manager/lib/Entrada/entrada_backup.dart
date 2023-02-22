import 'dart:io';
import 'dart:convert';
import 'package:finantial_manager/Entrada/Entrada_controller.dart';
import 'package:finantial_manager/Entrada/entrada.dart';
// ignore: unused_import
import 'package:path_provider/path_provider.dart';

class EntradaBackup {
  static Future<File> _getFile() async {
    //final directory = await getApplicationDocumentsDirectory();
    Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
    return File("${generalDownloadDir.path}/entradas-backup.txt");
  }

  static Future<File> saveFile() async {
    String data = "";

    List<Entrada> entradas = await EntradaController.readAll();

    for (var e in entradas) {
      data += ' ${jsonEncode(e.toJson())};';
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
