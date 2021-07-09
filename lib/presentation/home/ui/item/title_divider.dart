import 'package:flutter/material.dart';

class TitleDivider extends StatefulWidget {
  const TitleDivider({Key? key,required this.title
  }) : super(key: key);
  final String title;
  @override
  _TitleDividerState createState() => _TitleDividerState();
}

class _TitleDividerState extends State<TitleDivider> {
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            //fontFamily: "coiny",
          ),
        ),
        Stack(
          alignment: const Alignment(-1, 0),
          children: [
            SizedBox(
              width: _mediaQuery.width/2,
              child: const Divider(
                color: Colors.black,
              ),
            ),
            Container(
              color: Colors.black,
              height: 4,
              width: _mediaQuery.width/6,
            ),
          ],
        ),
      ],
    );
  }
}

