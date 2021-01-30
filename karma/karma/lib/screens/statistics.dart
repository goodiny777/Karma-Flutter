import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StatisticsWidget extends StatefulWidget {
  StatisticsWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<StatisticsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
              child: Icon(Icons.arrow_back, color: Colors.white,),
              onTap: () => {Navigator.pop(context)}),
          title: Text(
            'Statistics',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
      body: Column(
        children: [Text("Statistics screen")],
      ),
    );
  }
}
