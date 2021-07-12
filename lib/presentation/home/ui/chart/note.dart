import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  const Note(
      {Key? key,
      required this.title1,
      required this.title2,
      required this.title3,
      required this.colors1,
      required this.colors2,
      required this.colors3})
      : super(key: key);
  final String title1;
  final String title2;
  final String title3;
  final Color colors1;
  final Color colors2;
  final Color colors3;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                color: colors1,
                width: 20,
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(title1)
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                color: colors2,
                width: 20,
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(title2)
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                color: colors3,
                width: 20,
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(title3)
            ],
          ),
        ),
      ],
    );
  }
}
