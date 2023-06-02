import 'package:flutter/material.dart';

import '../constants.dart';

class StatusPages extends StatelessWidget {
  const StatusPages({
    Key? key,
    required this.textTitle,
  }) : super(key: key);

  final String textTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 0),
      height: 24,
      child: Stack(
        children: <Widget>[
          Text(
            textTitle,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Italic'),
          ),
        ],
      ),
    );
  }
}
