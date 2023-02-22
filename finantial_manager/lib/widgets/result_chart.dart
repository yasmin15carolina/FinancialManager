import 'package:finantial_manager/Saida/saida.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyGraphic extends StatefulWidget {
  List<Saida> saidas;
  MyGraphic({super.key, required this.saidas});

  @override
  State<MyGraphic> createState() => _MyGraphicState();
}

class _MyGraphicState extends State<MyGraphic> {
  getPeriodata(List<Saida> s) {
    List<FlSpot> spots = [];
    DateTime d = s.first.dateTime;
    spots.add(FlSpot(1, s.first.value));
    double value = s.first.value;
    for (var i = 1; i < s.length; i++) {
      isTheSameDay(s[i - 1].dateTime, s[i].dateTime)
          ? spots.last.copyWith(y: spots.last.y + s[i].value)
          : spots.add(FlSpot(spots.last.x + 1, s[i].value));
    }
    return spots;
  }

  bool isTheSameDay(DateTime dt1, DateTime dt2) {
    return dt1.day == dt2.day && dt1.month == dt2.month && dt1.year == dt2.year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: LineChart(LineChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  );
                  Widget text;
                  switch (value % 1 > 0.001 ? 0 : value.toInt()) {
                    case 1:
                      text = const Text('1', style: style);
                      break;
                    case 2:
                      text = const Text('2', style: style);
                      break;
                    case 12:
                      text = const Text('DEC', style: style);
                      break;
                    default:
                      text = const Text('');
                      break;
                  }

                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 10,
                    child: text,
                  );
                },
                reservedSize: 42,
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              // dashArray: [3],

              color: Colors.red,
              show: true,
              spots: getPeriodata(widget.saidas),
              // widget.saidas
              //     .map((e) =>
              //         FlSpot(widget.saidas.indexOf(e).toDouble(), e.value))
              //     .toList(),
              isCurved: false,
              barWidth: 2,
              // colors: [
              //   colors1,
              // ],
              dotData: FlDotData(
                  // show: true,

                  // dotColor: colors1,
                  // checkToShowDot: (spot){

                  //   if(spot.isNull()) {
                  //     return false;
                  //   }
                  //   else return true;
                  // }
                  ),
            ),
          ],
          // gridData: FlGridData()
        )),
      ),
    );
  }
}
