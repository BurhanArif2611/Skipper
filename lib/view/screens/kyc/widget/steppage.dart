import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

class StepPage extends StatelessWidget {
  final String title;
  final String content;

  StepPage({@required this.title, @required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Text(
            content,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}