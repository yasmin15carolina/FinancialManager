// ignore_for_file: unnecessary_null_comparison, await_only_futures, unused_local_variable

import 'dart:async';
import 'dart:io';
// ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as html;
import 'package:finantial_manager/Entrada/entrada.dart';
import 'package:finantial_manager/Entrada/entrada_controller.dart';
import 'package:finantial_manager/Saida/saida.dart';
import 'package:finantial_manager/Saida/saida_controller.dart';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class Excelfile {
  var excel = Excel.createExcel();
  late String name;
  Excelfile();
  final f = DateFormat('dd/MM/yyyy\nhh:mm');

  Future<String> exportSaidaData() async {
    excel.rename('Sheet1', "Saida");
    Sheet sheetObject = excel["Saida"];

    List<String> dataList = [
      "id",
      "Motivo",
      "Valor",
      "Data",
      "Fixo",
    ];

    sheetObject.insertRowIterables(dataList, 0);
    List<Saida> gastos = await SaidaController.readAll();

    for (var element in gastos) {
      List<dynamic> rowList = [];

      rowList.add(element.id);
      rowList.add(element.reason);
      rowList.add(element.value);
      rowList.add(f.format(element.dateTime));
      rowList.add(element.isFixed ? "True" : "False");

      sheetObject.insertRowIterables(rowList, gastos.indexOf(element) + 1);
    }
    excel.setDefaultSheet("Saida");
    var fileBytes = excel.save(fileName: "saidas.xlsx");
    Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
    var directory = await getApplicationDocumentsDirectory();

    File(join("${generalDownloadDir.path}/saidas.xlsx"))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    return "${generalDownloadDir.path}/saidas.xlsx";
  }

  readSaida(String path) {
    // Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
    // var bytes =
    //     File("${generalDownloadDir.path}/saidas.xlsx").readAsBytesSync();
    var bytes = File(path).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      List<List<Data?>> x = excel.tables[table]!.rows;
      x.removeAt(0);
      List<Saida> list = [];
      for (var row in x) {
        list.add(
          Saida(
              id: int.parse(row[0]!.value.toString()),
              reason: row[1]!.value.toString(),
              value: double.parse(row[2]!.value.toString()),
              dateTime: f.parse(row[3]!.value.toString()),
              isFixed: row[3]!.value.toString() == 'false' ? false : true),
        );
      }
      SaidaController.fromList(list);
    }
  }

  Future<String> exportEntradaData() async {
    excel.rename('Sheet1', "Entrada");
    Sheet sheetObject = excel["Entrada"];

    List<String> dataList = [
      "id",
      "Origem",
      "Valor",
      "Data",
      "Fixo",
    ];

    sheetObject.insertRowIterables(dataList, 0);
    List<Entrada> entradas = await EntradaController.readAll();

    for (var element in entradas) {
      List<dynamic> rowList = [];

      rowList.add(element.id);
      rowList.add(element.origin);
      rowList.add(element.value);
      rowList.add(f.format(element.dateTime));
      rowList.add(element.isFixed ? "True" : "False");

      sheetObject.insertRowIterables(rowList, entradas.indexOf(element) + 1);
    }
    excel.setDefaultSheet("Entrada");
    var fileBytes = excel.save(fileName: "entradas.xlsx");
    Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
    var directory = await getApplicationDocumentsDirectory();

    File(join("${generalDownloadDir.path}/entradas.xlsx"))
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);
    return "${generalDownloadDir.path}/entradas.xlsx";
  }

  readEntrada(String path) {
    // Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
    // var bytes =
    //     File("${generalDownloadDir.path}/saidas.xlsx").readAsBytesSync();
    var bytes = File(path).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      List<List<Data?>> x = excel.tables[table]!.rows;
      x.removeAt(0);
      List<Entrada> list = [];
      for (var row in x) {
        list.add(
          Entrada(
              id: int.parse(row[0]!.value.toString()),
              origin: row[1]!.value.toString(),
              value: double.parse(row[2]!.value.toString()),
              dateTime: f.parse(row[3]!.value.toString()),
              isFixed: row[3]!.value.toString() == 'False' ? false : true),
        );
      }
      EntradaController.fromList(list);
    }
  }
}
