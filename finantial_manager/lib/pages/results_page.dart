import 'package:finantial_manager/Entrada/entrada.dart';
import 'package:finantial_manager/Saida/saida.dart';
import 'package:finantial_manager/Entrada/entrada_controller.dart';
import 'package:finantial_manager/Saida/saida_controller.dart';
import 'package:finantial_manager/widgets/result_chart.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});
  final String? restorationId = 'main';
  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> with RestorationMixin {
  List<Saida> gastos = [];
  List<Entrada> entradas = [];
  double entrada = 0.0;
  double saida = 0.0;
  double saldo = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      gastos = await SaidaController.readAll();
      entradas = await EntradaController.readAll();
      setState(() {
        for (var element in gastos) {
          saida = saida + element.value;
        }
        for (var element in entradas) {
          entrada = entrada + element.value;
        }

        saldo = entrada - saida;
      });
    });
  }

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime.now(),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        if (isStart) {
          start = newSelectedDate;
          isStart = false;
        } else {
          end = newSelectedDate;
          isStart = true;
          search();
        }
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  DateTime end = DateTime.now();
  DateTime start = DateTime.now()
      .copyWith(day: DateTime.now().day - 7); //DateTime(DateTime.now().year,);
  bool isStart = true;

  String formatDate(DateTime t) {
    String month = "";
    switch (t.month) {
      case 1:
        month = "Jan";
        break;
      case 2:
        month = "Fev";
        break;
      case 3:
        month = "Mar";
        break;
      case 4:
        month = "Abr";
        break;
      case 5:
        month = "Mai";
        break;
      case 6:
        month = "Jun";
        break;
      case 7:
        month = "Jul";
        break;
      case 8:
        month = "Ago";
        break;
      case 9:
        month = "Set";
        break;
      case 10:
        month = "Out";
        break;
      case 11:
        month = "Nov";
        break;
      case 12:
        month = "Dez";
        break;
      default:
    }

    return "$month,${t.day} ${t.year}";
  }

  search() async {
    entrada = 0.0;
    saida = 0.0;
    saldo = 0.0;
    gastos = await SaidaController.fromPeriod(
        start.millisecondsSinceEpoch, end.millisecondsSinceEpoch);
    entradas = await EntradaController.fromPeriod(
        start.millisecondsSinceEpoch, end.millisecondsSinceEpoch);
    setState(() {
      for (var element in gastos) {
        saida = saida + element.value;
      }
      for (var element in entradas) {
        entrada = entrada + element.value;
      }

      saldo = entrada - saida;
    });
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: SaidaController.readAll(),
    //   builder: (context, snapshot) {
    //     gastos = snapshot.data as List<Saida>;

    //     return MyGraphic(saidas: gastos);
    //   },
    // );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Text("${formatDate(start)} - ${formatDate(end)}")),
                IconButton(
                  onPressed: () => _restorableDatePickerRouteFuture.present(),
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
          ),
          Center(
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
                columnSpacing: MediaQuery.of(context).size.width / 2,
                columns: const [
                  DataColumn(label: Text("")),
                  DataColumn(label: Text("Valor")),
                ],
                rows: [
                  DataRow(cells: [
                    const DataCell(Text("Entrada")),
                    DataCell(
                      Center(
                        child: Text(entrada.toStringAsFixed(2),
                            style: const TextStyle(color: Colors.green)),
                      ),
                    ),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text("Saída")),
                    DataCell(
                      Center(
                        child: Text(saida.toStringAsFixed(2),
                            style: const TextStyle(color: Colors.red)),
                      ),
                    ),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text("Saldo")),
                    DataCell(
                      Center(
                        child: Text(saldo.toStringAsFixed(2),
                            style: TextStyle(
                                color: saldo > 0 ? Colors.green : Colors.red)),
                      ),
                    ),
                  ]),
                ]),
          ),
        ],
      ),
    );
  }
}
