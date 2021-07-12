import 'package:covid19_app/presentation/common/array.dart';

import '../note.dart';
import '../../item/title_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fl_chart/fl_chart.dart';

class MyLineChart extends StatefulWidget {
  const MyLineChart({
    Key? key,
    required this.leftTittle,
    required this.bottomTittle,
    required this.maxY,
    required this.step,
    required this.spotCases,
    required this.spotDeaths,
    required this.spotRevovered,
  }) : super(key: key);
  final List<String> leftTittle;
  final List<dynamic> bottomTittle;
  final double maxY;
  final double step;
  final List<Spot> spotCases;
  final List<Spot> spotDeaths;
  final List<Spot> spotRevovered;

  @override
  _MyLineChart createState() => _MyLineChart();
}

class _MyLineChart extends State<MyLineChart> {
  double point(double c) {
    var p = widget.step * c;
    return p;
  }

  List<FlSpot> listSpotCases = [];
  List<FlSpot> listSpotDeaths = [];
  List<FlSpot> listSpotRecovered = [];

  List<FlSpot> convert(List<Spot> listSpot) {
    List<FlSpot> listSpotInForLoop = [];
    for (var i = 0; i < listSpot.length; i++) {
      if (i != 0) {
        var f = FlSpot(
            i * 1.0,
            listSpot.elementAt(i).value! * 1.0 -
                listSpot.elementAt(i - 1).value! * 1.0);
        listSpotInForLoop.add(f);
      } else {
        var f = FlSpot(
            i * 1.0,
            listSpot.elementAt(i + 1).value! * 1.0 -
                listSpot.elementAt(i).value! * 1.0);
        listSpotInForLoop.add(f);
      }
    }
    return listSpotInForLoop;
  }

  String subString(String s) {
    var monthAndDay = s.substring(0, s.length - 3);
    var day = monthAndDay.substring(monthAndDay.indexOf("/") + 1);
    var month = monthAndDay.substring(
        monthAndDay.indexOf("/") - 1, monthAndDay.indexOf("/"));
    var dayAndMonth = day + "/" + month;
    return dayAndMonth;
  }

  @override
  void initState() {
    listSpotCases = convert(widget.spotCases);
    listSpotDeaths = convert(widget.spotDeaths);
    listSpotRecovered = convert(widget.spotRevovered);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleDivider(title: "Biểu đồ"),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: _mediaQuery.height / 2,
            child: LineChart(
              LineChartData(
                  minX: 0,
                  maxX: widget.bottomTittle.length * 1.0 - 1,
                  maxY: widget.maxY,
                  minY: 0,
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                    ),
                    touchCallback: (LineTouchResponse touchResponse) {},
                    handleBuiltInTouches: true,
                  ),
                  gridData: FlGridData(
                    show: false,
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      getTextStyles: (value) => const TextStyle(
                        color: Color(0xff72719b),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      margin: 10,
                      getTitles: (value) {
                        switch (value.toInt()) {
                          case 0:
                            return subString(widget.bottomTittle.elementAt(0));
                          case 6:
                            return subString(widget.bottomTittle.elementAt(6));
                          case 12:
                            return subString(widget.bottomTittle.elementAt(12));
                          case 18:
                            return subString(widget.bottomTittle.elementAt(18));
                          case 24:
                            return subString(widget.bottomTittle.elementAt(24));
                          case 29:
                            return subString(widget.bottomTittle.elementAt(29));
                        }
                        return '';
                      },
                    ),
                    leftTitles: SideTitles(
                      showTitles: true,
                      getTextStyles: (value) => const TextStyle(
                        color: Color(0xff75729e),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      getTitles: (value) {
                        if (value.toInt() == point(0)) {
                          return widget.leftTittle[0] + "K";
                        } else if (value.toInt() == point(1)) {
                          return widget.leftTittle[1] + "K";
                        } else if (value.toInt() == point(2)) {
                          return widget.leftTittle[2] + "K";
                        } else if (value.toInt() == point(3)) {
                          return widget.leftTittle[3] + "K";
                        }else if (value.toInt() == point(4)) {
                          return widget.leftTittle[4] + "K";
                        }
                        return '';
                      },
                      margin: 8,
                      reservedSize: 30,
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      bottom: BorderSide(
                        color: Color(0xff4e4965),
                        width: 2,
                      ),
                      left: BorderSide(
                        color: Colors.transparent,
                      ),
                      right: BorderSide(
                        color: Colors.transparent,
                      ),
                      top: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: listSpotCases,
                      isCurved: true,
                      colors: const [Colors.yellow],
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: false,
                      ),
                    ),
                    LineChartBarData(
                      spots: listSpotDeaths,
                      isCurved: true,
                      colors: const [Colors.red],
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: false,
                      ),
                    ),
                    LineChartBarData(
                      spots: listSpotRecovered,
                      isCurved: true,
                      colors: const [Colors.green],
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: false,
                      ),
                      belowBarData: BarAreaData(
                        show: false,
                      ),
                    )
                  ]),
              swapAnimationDuration:
                  const Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            ),
          ),
        ),
        Note(
          title1: "Ca nhiễm mới",
          title2: "Ca tử vong mới",
          title3: "Ca hồi phục mới",
          colors1: Colors.yellow.shade700,
          colors2: Colors.red,
          colors3: Colors.green,
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
