import 'package:file_picker/file_picker.dart';
import 'package:finantial_manager/Entrada/entrada.dart';
import 'package:finantial_manager/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';

import '../classes/excel.dart';
import 'Entrada_controller.dart';

// ignore: must_be_immutable
class GridEntrada extends StatefulWidget {
  List<Entrada>? entrada;
  GridEntrada({super.key, this.entrada});

  @override
  State<GridEntrada> createState() => _GridEntradaState();
}

class _GridEntradaState extends State<GridEntrada> {
  @override
  void initState() {
    super.initState();
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
    int i = (widget.entrada!.length - 1 - index * nPagination > nPagination)
        ? index * nPagination + nPagination
        : widget.entrada!.length;
    return i;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: EntradaController.readAll(),
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
        widget.entrada = snapshot.data as List<Entrada>;

        return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "${index + 1} / ${widget.entrada!.length ~/ nPagination + 1}"),
                  IconButton(
                    onPressed: () async {
                      Excelfile e = Excelfile();
                      String path = await e.exportEntradaData();
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
                        await e.readEntrada(result.files.single.path!);
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
                      headingRowHeight: 56,
                      dataRowHeight: 56,
                      columns: const [
                        // DataColumn(label: Text("Origem")),
                        DataColumn(label: Text("Valor")),
                        DataColumn(label: Text("Data")),
                        DataColumn(label: Text("")),
                        DataColumn(label: Text("")),
                      ],
                      rows: widget.entrada!
                          .sublist(index * nPagination, getEndOFList())
                          .map((e) => DataRow(cells: [
                                // DataCell(Text(e.origin)),
                                DataCell(Text(e.value.toString())),
                                DataCell(Text(f.format(e.dateTime))),
                                DataCell(
                                  const Icon(Icons.edit),
                                  onTap: () async {
                                    TextEditingController originController =
                                        TextEditingController(text: e.origin);
                                    TextEditingController valueController =
                                        TextEditingController(
                                            text: e.value.toString());
                                    Dialogs.showEdit(
                                      context: context,
                                      movimentacao: originController,
                                      valor: valueController,
                                      onConfirm: () async {
                                        e.origin = originController.text;
                                        e.value =
                                            double.parse(valueController.text);
                                        await EntradaController.update(e);
                                        widget.entrada =
                                            await EntradaController.readAll();
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
                                          await EntradaController.delete(e.id!);
                                          widget.entrada =
                                              await EntradaController.readAll();
                                          setState(() {});
                                        });
                                  },
                                ),
                              ]))
                          .toList()),
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
                    onPressed: (index < widget.entrada!.length ~/ nPagination)
                        ? () => setState(() {
                              index++;
                            })
                        : null,
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
