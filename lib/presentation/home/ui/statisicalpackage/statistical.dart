
import '../item/title_divider.dart';
import 'box_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Statistical extends StatefulWidget {
  const Statistical({Key? key,
    required this.infected,
    required this.recovered,
    required this.death,
    required this.country,
    required this.newInfected,
    required this.newRecovered,
    required this.newDeath,
  }) : super(key: key);
  final int infected;
  final int recovered;
  final int death;
  final String country;
  final int newInfected;
  final int newRecovered;
  final int newDeath;
  @override
  _Statistical createState() => _Statistical();
}

class _Statistical extends State<Statistical> {
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       TitleDivider(title: "Thống kê Covid "+widget.country),
        const SizedBox(height: 20),
        Row(
          children: [
          BoxCount(count: widget.infected.toString(),
            newCount: widget.newInfected.toString(),
            color: Colors.yellow.shade700,
            title:"Tổng số ca",
            bottomColor: Colors.yellow.shade900,
          ),
            const SizedBox(
              width: 10,
            ),
            BoxCount(count: widget.death.toString(),
              newCount: widget.newDeath.toString(),
              color: Colors.red,title: "Tử vong",
              bottomColor: Colors.red.shade700,
            ),
            const SizedBox(
              width: 10,
            ),
            BoxCount(count: widget.recovered.toString(),
              newCount: widget.newRecovered.toString(),
              color: Colors.green,
              title: "Hồi phục",
              bottomColor: Colors.green.shade700,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

