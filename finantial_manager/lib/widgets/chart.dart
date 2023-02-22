// import 'package:finantial_manager/Entrada/entrada.dart';
// import 'package:finantial_manager/Saida/saida.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class ChartItem {
//   final DateTime dateTime;
//   final double value;

//   ChartItem(this.dateTime, this.value);
// }

// List<ChartItem> prepareChartData(List<Entrada> entradas, List<Saida> saidas) {
//   final today = DateTime.now().toLocal();
//   final lastMonth = today.subtract(Duration(days: 30));
//   final chartData = List.generate(30, (index) {
//     final day = lastMonth.add(Duration(days: index));
//     final dayStart = DateTime(day.year, day.month, day.day);
//     final dayEnd = DateTime(day.year, day.month, day.day, 23, 59, 59);
//     final entradasNoDia = entradas
//         .where((entrada) =>
//             entrada.dateTime.isAfter(dayStart) &&
//             entrada.dateTime.isBefore(dayEnd))
//         .map((entrada) => entrada.value)
//         .fold(0, (prev, value) => (prev + value).toInt());
//     final saidasNoDia = saidas
//         .where((saida) =>
//             saida.dateTime.isAfter(dayStart) && saida.dateTime.isBefore(dayEnd))
//         .map((saida) => saida.value)
//         .fold(0, (prev, value) => (prev + value).toInt());
//     return ChartItem(day, (entradasNoDia - saidasNoDia).toDouble());
//   });
//   return chartData;
// }

// class MyChart extends StatelessWidget {
//   final List<Entrada> entradas;
//   final List<Saida> saidas;

//   MyChart({required this.entradas, required this.saidas});

//   @override
//   Widget build(BuildContext context) {
//     final chartData = prepareChartData(entradas, saidas);
//     return Scaffold(
//       body: Container(
//         child: LineChart(
//           LineChartData(
//             minX: chartData.first.dateTime.millisecondsSinceEpoch.toDouble(),
//             maxX: chartData.last.dateTime.millisecondsSinceEpoch.toDouble(),
//             minY: 0,
//             lineBarsData: [
//               LineChartBarData(
//                 spots: chartData
//                     .map((item) => FlSpot(
//                           item.dateTime.millisecondsSinceEpoch.toDouble(),
//                           item.value,
//                         ))
//                     .toList(),
//                 isCurved: true,
//                 // colors: [Colors.blue],
//                 barWidth: 3,
//                 dotData: FlDotData(show: false),
//               ),
//             ],
//             titlesData: FlTitlesData(
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 22,
//                     // margin: 10,
//                     getTitlesWidget: (value, meta) {
//                       final date =
//                           DateTime.fromMillisecondsSinceEpoch(value.toInt());
//                       return Text('${date.day}/${date.month}');
//                     },
//                   ),
//                 ),
//                 leftTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     // margin: 10,
//                     // getTitlesWidget: TextStyle(
//                     //     color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)
//                   ),
//                 )),
//           ),
//         ),
//       ),
//     );
//   }
// }
