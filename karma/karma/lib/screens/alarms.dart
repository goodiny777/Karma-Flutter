import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karma/screens/statistics.dart';

class AlarmsWidget extends StatefulWidget {
  AlarmsWidget({Key key}) : super(key: key);

  @override
  _AlarmsState createState() => _AlarmsState();
}

class _AlarmsState extends State<AlarmsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
              child: Icon(Icons.arrow_back, color: Colors.white,),
              onTap: () => {Navigator.pop(context)}),
          title: Text(
            'Alarms',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
      body: Column(
        children: [

        ],
      ),
    );
  }
}