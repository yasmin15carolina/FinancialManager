import 'package:file_picker/file_picker.dart';
import 'package:finantial_manager/Saida/saida.dart';
import 'package:finantial_manager/Saida/saida_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';

import '../classes/excel.dart';
import '../widgets/dialog.dart';

// ignore: must_be_immutable
class GridSaida extends StatefulWidget {
  List<Saida>? gastos;
  GridSaida({super.key, this.gastos});

  @override
  State<GridSaida> createState() => _GridSaidaState();
}

class _GridSaidaState extends State<GridSaida> {
  // List<Saida>? saidas = [];
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () async {
    //   // tabController!.addListener(() async {
    //   //   if (tabController!.indexIsChanging) {
    //   widget.gastos = await SaidaController.readAll();
    //   //     setState(() {});
    //   //     print(saidas);
    //   //   }
    //   // });
    // });
  }

  String dateFormat(DateTime date) {
    return "${date.day.toStringAsPrecision(2)}/${date.month.toStringAsFixed(2)}/${date.year}";
  }

  final f = DateFormat('dd/MM/yyyy\nhh:mm');

  DateTime start = DateTime(2020);
  DateTime end = DateTime(2020);

  int nPagination = 7;
  int index = 0;

  int getEndOFList() {
    int i = (widget.gastos!.length - 1 - index * nPagination > nPagination)
        ? index * nPagination + nPagination
        : widget.gastos!.length;
    return i;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SaidaController.readAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Error fetching data: ${snapshot.error}"),
          );
        }
        widget.gastos = snapshot.data as List<Saida>;

        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text("Periodo: $start - $end"),
                  Text(
                      "${index + 1} / ${widget.gastos!.length ~/ nPagination + 1}"),
                  IconButton(
                    onPressed: () async {
                      Excelfile e = Excelfile();
                      String path = await e.exportSaidaData();
                      OpenFilex.open(path).then((value) => Dialogs.show(
                          context: context,
                          content: value.message,
                          title: "Abrir arquivo"));
                    },
                    icon: const Icon(Icons.download),
                  ),
                  IconButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                              allowedExtensions: ['xlsx'],
                              type: FileType.custom);

                      if (result != null) {
                        Excelfile e = Excelfile();
                        await e.readSaida(result.files.single.path!);
                        setState(() {});
                        Dialogs.show(
                            context: context,
                            content: "Os dados foram importados!",
                            title: "Importar Dados");
                      } else {
                        // User canceled the picker
                      }
                    },
                    icon: const Icon(Icons.upload),
                  ),
                ],
              ),
              Scrollbar(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    // headingRowColor: MaterialStateColor.resolveWith(
                    //   (states) {
                    //     return Color.fromARGB(255, 151, 44, 170);
                    //   },
                    // ),
                    border: TableBorder.all(
                      width: 1.0,
                      color: Colors.black,
                    ),
                    dividerThickness: 5,
                    // decoration: BoxDecoration(
                    //   border: Border(
                    //       right: Divider.createBorderSide(context, width: 1.0),
                    //       left: Divider.createBorderSide(context, width: 1.0)),
                    //   color: Colors.black,
                    // ),
                    headingRowHeight: 56,
                    dataRowHeight: 56,
                    columns: const [
                      // DataColumn(label: Text("Motivo")),
                      DataColumn(label: Text("Valor")),
                      DataColumn(label: Text("Data")),
                      DataColumn(label: Text("")),
                      DataColumn(label: Text("")),
                    ],
                    rows: widget.gastos!
                        .sublist(index * nPagination, getEndOFList())
                        .map(
                          (g) => DataRow(cells: [
                            // DataCell(Text(g.reason)),
                            DataCell(Text(g.value.toString())),
                            DataCell(Text(f.format(g.dateTime))),
                            DataCell(
                              const Icon(Icons.edit),
                              onTap: () async {
                                TextEditingController reasonController =
                                    TextEditingController(text: g.reason);
                                TextEditingController valueController =
                                    TextEditingController(
                                        text: g.value.toString());
                                Dialogs.showEdit(
                                  context: context,
                                  movimentacao: reasonController,
                                  valor: valueController,
                                  onConfirm: () async {
                                    g.reason = reasonController.text;
                                    g.value =
                                        double.parse(valueController.text);
                                    g.dateTime = f.parse('15/01/2023 08:30');
                                    await SaidaController.update(g);
                                    widget.gastos =
                                        await SaidaController.readAll();
                                    setState(() {});
                                  },
                                );
                              },
                            ),
                            DataCell(
                              const Icon(Icons.delete),
                              onTap: () async {
                                Dialogs.showDelete(
                                    context: context,
                                    onConfirm: () async {
                                      await SaidaController.delete(g.id!);
                                      widget.gastos =
                                          await SaidaController.readAll();
                                      setState(() {});
                                    });
                              },
                            ),
                          ]),
                        )
                        .toList(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(const CircleBorder())),
                    onPressed: index > 0
                        ? () => setState(() {
                              index--;
                            })
                        : null,
                    child: const Icon(Icons.arrow_back),
                  ),
                  FilledButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(const CircleBorder())),
                    onPressed: (index < widget.gastos!.length ~/ nPagination)
                        ? () => setState(() {
                              index++;
                            })
                        : null,
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              // FilledButton(
              //   onPressed: () async {
              //     // Excelfile e = Excelfile();
              //     // e.createSheet();
              //     Arquivo.saveFile();
              //     // var v = await Arquivo.readFile();
              //     // print(v);
              //   },
              //   child: Text("a"),
              // )
            ],
          ),
        );
      },
    );
  }
}
