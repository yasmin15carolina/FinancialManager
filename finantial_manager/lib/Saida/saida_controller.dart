import 'dart:convert';

import 'package:finantial_manager/Saida/saida.dart';
import 'package:finantial_manager/Saida/saida_backup.dart';
import 'package:finantial_manager/db/manager_database.dart';

class SaidaController {
  // static Future getRows() async {
  //   final db = await ManagerDatabase.instance.database;

  //   var value = await Arquivo.readFile();
  //   var querys = value!.split(';');
  //   for (var i = 2; i < querys.length - 2; i++) {
  //     if (querys[i] != "") {
  //       create(Saida.fromJson(jsonDecode(querys[i])));
  //     }
  //   }
  //   EntradaController.create(
  //       Entrada.fromJson(jsonDecode(querys[querys.length - 2])));
  // }

  static Future createFromFile() async {
    var value = await SaidaBackup.readFile();
    var querys = value!.split(';').removeLast();
    for (var i = 0; i < querys.length; i++) {
      if (querys[i] != "") {
        create(Saida.fromJson(jsonDecode(querys[i])));
      }
    }
  }

  static Future fromList(List<Saida> saidas) async {
    final db = await ManagerDatabase.instance.database;
    for (var s in saidas) {
      s.id = null;
      //ignore: unused_local_variable
      final id = await db!.insert(tableSaidas, s.toJson());
    }
    // return saida.copy();
  }

  static Future<Saida> create(Saida saida) async {
    final db = await ManagerDatabase.instance.database;

    await db!.insert(tableSaidas, saida.toJson());
    return saida.copy();
  }

  static Future<Saida> read(int id) async {
    final db = await ManagerDatabase.instance.database;

    final maps = await db!.query(tableSaidas,
        columns: SaidasFields.values,
        where: '${SaidasFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Saida.fromJson(maps.first);
    } else {
      throw Exception('ID: $id not found');
    }
  }

  static Future<List<Saida>> fromPeriod(int since, int until) async {
    final db = await ManagerDatabase.instance.database;

    final result = await db!.rawQuery(
        'SELECT * FROM $tableSaidas WHERE ${SaidasFields.dateTime} > $since AND ${SaidasFields.dateTime} < $until ORDER BY ${SaidasFields.dateTime} ASC');

    return result.map((json) => Saida.fromJson(json)).toList();
  }

  static Future<List<Saida>> readAll() async {
    final db = await ManagerDatabase.instance.database;
    const orderBy = '${SaidasFields.dateTime} ASC';
    final result = await db!.query(tableSaidas, orderBy: orderBy);

    return result.map((json) => Saida.fromJson(json)).toList();
  }

  static Future update(Saida saida) async {
    final db = await ManagerDatabase.instance.database;

    await db!.update(
      tableSaidas,
      saida.toJson(),
      where: '${SaidasFields.id} = ?',
      whereArgs: [saida.id],
    );

    // if (maps) {
    //   return Gasto.fromJson(maps.first);
    // } else {
    //   throw Exception('ID: $id not found');
    // }
  }

  static Future delete(int id) async {
    final db = await ManagerDatabase.instance.database;

    await db!
        .delete(tableSaidas, where: '${SaidasFields.id} = ?', whereArgs: [id]);
  }
}


    // const columns =
    //     '${GastosFields.reason}, ${GastosFields.value}, ${GastosFields.dateTime}, ${GastosFields.isFixed}';
    // final values =
    //     '${json[GastosFields.reason]}, ${json[GastosFields.value]}, ${json[GastosFields.dateTime]}, ${json[GastosFields.isFixed]}';

    // final id = await db!
    //     .rawInsert('INSERT INTO $tableGastos ($columns) VALUES ($values)');

