import 'dart:async';

import 'package:finantial_manager/Entrada/entrada.dart';
import 'package:finantial_manager/Saida/saida.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class ManagerDatabase {
  static final ManagerDatabase instance = ManagerDatabase._init();

  static Database? _database;

  ManagerDatabase._init();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDB('b.db');
    return _database;
  }

  Future<Database?> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  FutureOr<void> _createDatabase(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const doubleType = 'REAL NOT NULL';

    await db.execute('''
        CREATE TABLE $tableSaidas (
          ${SaidasFields.id} $idType,
          ${SaidasFields.reason} $textType,
          ${SaidasFields.value} $doubleType,
          ${SaidasFields.dateTime} $integerType,
          ${SaidasFields.isFixed} $boolType
        )
      ''');

    await db.execute('''
        CREATE TABLE $tableEntradas (
          ${EntradasFields.id} $idType,
          ${EntradasFields.origin} $textType,
          ${EntradasFields.value} $doubleType,
          ${EntradasFields.dateTime} $integerType,
          ${EntradasFields.isFixed} $boolType
        )
      ''');

    // var value = await Arquivo.readFile();
    // var querys = value!.split(';');
    // for (var i = 0; i < 2; i++) {
    //   if (querys[i] != "") {
    //     await db.execute(querys[i]);
    //   }
    // }
  }

  // Future<Saida> create(Saida gasto) async {
  //   final db = await instance.database;
  //   final json = gasto.toJson();

  //   // const columns =
  //   //     '${GastosFields.reason}, ${GastosFields.value}, ${GastosFields.dateTime}, ${GastosFields.isFixed}';
  //   // final values =
  //   //     '${json[GastosFields.reason]}, ${json[GastosFields.value]}, ${json[GastosFields.dateTime]}, ${json[GastosFields.isFixed]}';

  //   // final id = await db!
  //   //     .rawInsert('INSERT INTO $tableGastos ($columns) VALUES ($values)');

  //   final id = await db!.insert(tableSaidas, gasto.toJson());
  //   return gasto.copy();
  // }

  // Future<Saida> readGasto(int id) async {
  //   final db = await instance.database;

  //   final maps = await db!.query(tableSaidas,
  //       columns: SaidasFields.values,
  //       where: '${SaidasFields.id} = ?',
  //       whereArgs: [id]);

  //   if (maps.isNotEmpty) {
  //     return Saida.fromJson(maps.first);
  //   } else {
  //     throw Exception('ID: $id not found');
  //   }
  // }

  // Future deleteGasto(int id) async {
  //   final db = await instance.database;

  //   final maps = await db!
  //       .delete(tableSaidas, where: '${SaidasFields.id} = ?', whereArgs: [id]);

  //   // if (maps.isNotEmpty) {
  //   //   return Gasto.fromJson(maps.first);
  //   // } else {
  //   //   throw Exception('ID: $id not found');
  //   // }
  // }

  // Future<List<Saida>> readAllGastos() async {
  //   final db = await instance.database;
  //   const orderBy = '${SaidasFields.dateTime} ASC';
  //   final result = await db!.query(tableSaidas, orderBy: orderBy);

  //   return result.map((json) => Saida.fromJson(json)).toList();
  // }

  Future close() async {
    final db = await instance.database;

    db!.close();
  }
}
