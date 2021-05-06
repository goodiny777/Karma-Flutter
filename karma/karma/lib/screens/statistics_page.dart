import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karma/general/db.dart';
import 'package:karma/models/deed.dart';
import 'package:pie_chart/pie_chart.dart';

class StatisticsWidget extends StatefulWidget {
  StatisticsWidget({Key? key, this.title}) : super(key: key);
  final String? title;
  final DBProvider _dbProvider = DBProvider.db;
  List<Deed> deeds = [];

  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<StatisticsWidget> {
  @override
  void initState() {
    widget._dbProvider
        .getAllDeeds()
        .then((value) => widget.deeds = value)
        .whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () => {Navigator.pop(context)}),
          title: Text(
            'Statistics',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
      body: Center(
        child: PieChart(
          dataMap: {
            "Good": widget.deeds
                .where((element) => element.type == true)
                .length
                .toDouble(),
            "Bad": widget.deeds
                .where((element) => element.type == false)
                .length
                .toDouble()
          },
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width,
          colorList: [Colors.lightGreen, Colors.redAccent],
          legendOptions: LegendOptions(
            showLegendsInRow: true,
            legendPosition: LegendPosition.top,
            showLegends: true,
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: false,
            showChartValues: true,
            showChartValuesInPercentage: true,
            showChartValuesOutside: false,
            decimalPlaces: 1,
          ),
        ),
      ),
    );
  }
}
