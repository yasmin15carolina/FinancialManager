import 'dart:async';
import 'dart:convert';

import 'package:finantial_manager/Entrada/entrada.dart';
import 'package:finantial_manager/Entrada/entrada_backup.dart';
import 'package:finantial_manager/db/manager_database.dart';

class EntradaController {
  static Future<Entrada> create(Entrada entrada) async {
    final db = await ManagerDatabase.instance.database;

    // ignore: unused_local_variable
    final id = await db!.insert(tableEntradas, entrada.toJson());
    return entrada.copy();
  }

  static Future createFromFile() async {
    var value = await EntradaBackup.readFile();
    var querys = value!.split(';').removeLast();
    for (var i = 0; i < querys.length; i++) {
      if (querys[i] != "") {
        create(Entrada.fromJson(jsonDecode(querys[i])));
      }
    }
  }

  static Future fromList(List<Entrada> saidas) async {
    final db = await ManagerDatabase.instance.database;
    for (var e in saidas) {
      e.id = null;
      await db!.insert(tableEntradas, e.toJson());
    }
    // return saida.copy();
  }

  static Future<Entrada> readEntrada(int id) async {
    final db = await ManagerDatabase.instance.database;

    final maps = await db!.query(tableEntradas,
        columns: EntradasFields.values,
        where: '${EntradasFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Entrada.fromJson(maps.first);
    } else {
      throw Exception('ID: $id not found');
    }
  }

  static Future<List<Entrada>> readAll() async {
    final db = await ManagerDatabase.instance.database;
    const orderBy = '${EntradasFields.dateTime} ASC';
    final result = await db!.query(tableEntradas, orderBy: orderBy);

    return result.map((json) => Entrada.fromJson(json)).toList();
  }

  static Future<List<Entrada>> fromPeriod(int since, int until) async {
    final db = await ManagerDatabase.instance.database;
    final result = await db!.rawQuery(
        'SELECT * FROM $tableEntradas WHERE ${EntradasFields.dateTime} > $since AND ${EntradasFields.dateTime} < $until ORDER BY ${EntradasFields.dateTime} ASC');
    //     query(
    //   tableEntradas,
    //   where: '${EntradasFields.dateTime} > ? && ${EntradasFields.dateTime} < ?',
    //   whereArgs: [since, until],
    //   orderBy: orderBy,
    // );

    return result.map((json) => Entrada.fromJson(json)).toList();
  }

  static Future update(Entrada entrada) async {
    final db = await ManagerDatabase.instance.database;

    await db!.update(
      tableEntradas,
      entrada.toJson(),
      where: '${EntradasFields.id} = ?',
      whereArgs: [entrada.id],
    );

    // if (maps) {
    //   return Gasto.fromJson(maps.first);
    // } else {
    //   throw Exception('ID: $id not found');
    // }
  }

  static Future delete(int id) async {
    final db = await ManagerDatabase.instance.database;

    await db!.delete(tableEntradas,
        where: '${EntradasFields.id} = ?', whereArgs: [id]);
  }
}
