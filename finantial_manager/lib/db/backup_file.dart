// ignore: file_names
// import 'dart:io';
// import 'dart:convert';
// import 'package:finantial_manager/Entrada/entrada.dart';
// import 'package:finantial_manager/Saida/saida.dart';
// import 'package:path_provider/path_provider.dart';

// class Arquivo {
//   static Future<File> _getFile() async {
//     final directory = await getApplicationDocumentsDirectory();
//     Directory generalDownloadDir = Directory('/storage/emulated/0/Download');
//     return File("${generalDownloadDir.path}/bacup.txt");
//   }

//   static Future<File> saveFile() async {
//     const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//     const textType = 'TEXT NOT NULL';
//     const boolType = 'BOOLEAN NOT NULL';
//     const integerType = 'INTEGER NOT NULL';
//     const doubleType = 'REAL NOT NULL';

//     // String tables = '''
//     //     CREATE TABLE $tableSaidas (
//     //       ${SaidasFields.id} $idType,
//     //       ${SaidasFields.reason} $textType,
//     //       ${SaidasFields.value} $doubleType,
//     //       ${SaidasFields.dateTime} $integerType,
//     //       ${SaidasFields.isFixed} $boolType
//     //     )\n
//     //   ''';
//     // tables += '''
//     //     CREATE TABLE $tableEntradas (
//     //       ${EntradasFields.id} $idType,
//     //       ${EntradasFields.origin} $textType,
//     //       ${EntradasFields.value} $doubleType,
//     //       ${EntradasFields.dateTime} $integerType,
//     //       ${EntradasFields.isFixed} $boolType
//     //     )\n
//     //   ''';
//     // String data = tables;

//     // List<Saida> saidas = await SaidaController.readAll();

//     // saidas.forEach((s) {
//     //   data +=
//     //       '''INSERT INTO $tableSaidas VALUES (${s.id},${s.reason},${s.value},${s.dateTime.millisecondsSinceEpoch},${s.isFixed})\n''';
//     // });
//     // List<Entrada> entradas = await EntradaController.readAll();

//     // entradas.forEach((s) {
//     //   data +=
//     //       '''INSERT INTO $tableEntradas VALUES (${s.id},${s.origin},${s.value},${s.dateTime.millisecondsSinceEpoch},${s.isFixed})\n''';
//     // });

//     String data = """
//         CREATE TABLE Saidas (
//           _id INTEGER PRIMARY KEY AUTOINCREMENT,
//           reason TEXT NOT NULL,
//           value REAL NOT NULL,
//           dateTime INTEGER NOT NULL,
//           isFixed BOOLEAN NOT NULL
//         );

//               CREATE TABLE Entradas (
//           _id INTEGER PRIMARY KEY AUTOINCREMENT,
//           origin TEXT NOT NULL,
//           value REAL NOT NULL,
//           dateTime INTEGER NOT NULL,
//           isFixed BOOLEAN NOT NULL
//         );

//       ${jsonEncode(Saida(id: 1, reason: 'a', value: 52.00, dateTime: DateTime.fromMillisecondsSinceEpoch(1676312051082), isFixed: false).toJson())};
//       ${jsonEncode(Saida(id: 2, reason: 'b', value: 36.00, dateTime: DateTime.fromMillisecondsSinceEpoch(1676467251187), isFixed: false).toJson())};
//       ${jsonEncode(Saida(id: 3, reason: 'c', value: 10.00, dateTime: DateTime.fromMillisecondsSinceEpoch(1676467253153), isFixed: false).toJson())};
//       ${jsonEncode(Saida(id: 4, reason: 'd', value: 9.99, dateTime: DateTime.fromMillisecondsSinceEpoch(1676467254060), isFixed: false).toJson())};
//       ${jsonEncode(Saida(id: 5, reason: 'e', value: 48.50, dateTime: DateTime.fromMillisecondsSinceEpoch(1676487400197), isFixed: true).toJson())};
//       ${jsonEncode(Entrada(id: 1, origin: 'e', value: 5000.50, dateTime: DateTime.fromMillisecondsSinceEpoch(1676487400197), isFixed: true).toJson())};
      
// """;

//     final file = await _getFile();
//     return file.writeAsString(data);
//   }

//   static Future<File> saveFileLogin(
//       String email, nome, idUsuario, cnpj, idEmpresa, senha) async {
//     final Map<String, dynamic> newLogin = Map();
//     newLogin["email"] = email;
//     newLogin["nome"] = nome;
//     newLogin["id_usuario"] = idUsuario;
//     newLogin["cnpj"] = cnpj;
//     newLogin["idEmpresa"] = idEmpresa;
//     newLogin["senha"] = senha;

//     String data = json.encode(newLogin);

//     final file = await _getFile();
//     return file.writeAsString(data);
//   }

//   static Future<String?> readFile() async {
//     try {
//       final file = await _getFile();
//       var isExist = await file.exists();
//       if (isExist)
//         return file.readAsString();
//       else
//         return null;
//     } catch (e) {
//       return null;
//     }
//   }

//   static deleteFileLogin() async {
//     try {
//       final file = await _getFile();
//       var isExist = await file.exists();
//       if (isExist) {
//         file.delete();
//       }
//     } catch (e) {
//       return null;
//     }
//   }
// }
