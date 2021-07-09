
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BoxCount extends StatefulWidget {
  const BoxCount(
      {Key? key,
      required this.count,
      required this.newCount,
      required this.color,
      required this.title,
      required this.bottomColor})
      : super(key: key);
  final String count;
  final String newCount;
  final Color color;
  final Color bottomColor;
  final String title;
  @override
  _BoxCount createState() => _BoxCount();
}

class _BoxCount extends State<BoxCount> {
  final formatter = NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
        ),
        height: (MediaQuery.of(context).size.width-60)/3,
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Expanded(
              flex: 12,
              child: Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width/25),
              ),
            ),

            Expanded(
              flex: 12,
              child: Text(
                formatter.format(int.parse(widget.count)),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width/25
                    ),
              ),
            ),

            Expanded(
              flex: 10,
              child: Container(
                  width: double.infinity,
                  height: 22,
                  decoration: BoxDecoration(
                    color: widget.bottomColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "+" + formatter.format(int.parse(widget.newCount)),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width/25
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
