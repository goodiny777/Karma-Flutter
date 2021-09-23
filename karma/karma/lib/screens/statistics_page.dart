import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karma/general/constants.dart';
import 'package:karma/general/db.dart';
import 'package:karma/models/deed.dart';
import 'package:pie_chart/pie_chart.dart';

class StatisticsWidget extends StatefulWidget {
  StatisticsWidget({Key? key, this.title}) : super(key: key);
  final String? title;
  final DBProvider _dbProvider = DBProvider.db;
  List<Deed> deeds = [];
  StatisticFilter? _filter = StatisticFilter.byAmount;

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
            backgroundColor: Colors.amberAccent,
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
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            getToggleWidgets(),
            Center(
              child: PieChart(
                dataMap: {
                  "Good": widget._filter == StatisticFilter.byAmount
                      ? widget.deeds
                          .where((element) => element.type == true)
                          .length
                          .toDouble()
                      : widget.deeds
                          .where((element) => element.type == true)
                          .map((e) => e.value)
                          .fold(0, (p, c) => p + c!),
                  "Bad": widget._filter == StatisticFilter.byAmount
                      ? widget.deeds
                          .where((element) => element.type == false)
                          .length
                          .toDouble()
                      : widget.deeds
                          .where((element) => element.type == false)
                          .map((e) => e.value)
                          .fold(0, (p, c) => p + c!),
                },
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width,
                colorList: [materialAppLightGreen, materialAppYellow],
                legendOptions: LegendOptions(
                  showLegendsInRow: true,
                  legendPosition: LegendPosition.bottom,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValues: true,
                  showChartValuesInPercentage:
                      widget._filter == StatisticFilter.byPercent,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
              ),
            ),
          ],
        ));
  }

  Widget getToggleWidgets() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Radio<StatisticFilter>(
                value: StatisticFilter.byAmount,
                groupValue: widget._filter,
                onChanged: (StatisticFilter? value) {
                  setState(() {
                    widget._filter = value;
                  });
                },
              ),
              Text('By Amount')
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Radio<StatisticFilter>(
                value: StatisticFilter.byValue,
                groupValue: widget._filter,
                onChanged: (StatisticFilter? value) {
                  setState(() {
                    widget._filter = value;
                  });
                },
              ),
              Text('By Value')
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Radio<StatisticFilter>(
                value: StatisticFilter.byPercent,
                groupValue: widget._filter,
                onChanged: (StatisticFilter? value) {
                  setState(() {
                    widget._filter = value;
                  });
                },
              ),
              Text('By Percent')
            ],
          ),
        ),
      ],
    );
  }
}

enum StatisticFilter { byAmount, byValue, byPercent }
