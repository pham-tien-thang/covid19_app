import '../note.dart';
import '../../item/title_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class MyPieChart extends StatefulWidget {
  const MyPieChart(
      {Key? key,
      required this.valueDeath,
      required this.valueInfected,
      required this.valueRecovered})
      : super(key: key);
  final int valueDeath;
  final int valueInfected;
  final int valueRecovered;
  @override
  _MyPieChart createState() => _MyPieChart();
}

class _MyPieChart extends State<MyPieChart> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: const TitleDivider(title: "Biểu đồ")),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: _mediaQuery.height / 2.5,
          child: PieChart(
            PieChartData(
                pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                  setState(() {
                    final desiredTouch =
                        pieTouchResponse.touchInput is! PointerExitEvent &&
                            pieTouchResponse.touchInput is! PointerUpEvent;
                    if (desiredTouch &&
                        pieTouchResponse.touchedSection != null) {
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    } else {
                      touchedIndex = -1;
                    }
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: _mediaQuery.height / 18,
                sections: showingSections()),
          ),
        ),
        const Note(
          title3: "Hồi phục",
          title2: "Tử vong",
          title1: "Đang nhiễm",
          colors3: Colors.green,
          colors2: Colors.red,
          colors1: Colors.blue,
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    final formatter = NumberFormat("#,###");
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 10.0;
      final radius = isTouched
          ? MediaQuery.of(context).size.height / 7
          : MediaQuery.of(context).size.height / 10;
      String title(String t) {
        if (t.isNotEmpty && t.length < 4) {
          return t;
        } else if (t.length > 3 && t.length < 7) {
          return formatter.format(int.parse(t)).substring(0, t.length - 3) + "K";
        } else {
          return   formatter.format(int.parse(t)).substring(0,t.length-6)+"M";
        }

      }

      var sum =
          (widget.valueDeath + widget.valueRecovered + widget.valueInfected) *
              1.0;
      String ratio(double value) {
        var result = value * 100 / sum;
        return result.toStringAsFixed(1) + "%";
      }

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: widget.valueInfected * 1.0,
            title: isTouched
                ? title(widget.valueInfected.toString())
                : ratio(widget.valueInfected * 1.0),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: widget.valueRecovered * 1.0,
            title: isTouched
                ? title(widget.valueRecovered.toString())
                : ratio(widget.valueRecovered * 1.0),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.red,
            value: widget.valueDeath * 1.0,
            title: isTouched
                ? title(widget.valueDeath.toString())
                : ratio(widget.valueDeath * 1.0),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
