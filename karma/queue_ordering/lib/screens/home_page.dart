import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List<String> typeOneTimes = [
  "10:00",
  "10:15",
  "10:30",
  "10:45",
  "11:00",
  "11:15",
  "11:30",
];

final List<String> typeTwoTimes = [
  "12:00",
  "12:30",
  "13:00",
  "13:30",
  "14:00",
  "14:30",
  "15:00",
  "15:30",
];

class HomePage extends StatefulWidget {
  List<List<String>> times = [typeOneTimes, typeTwoTimes];

  List<bool> _isToggleSelected = [false, true];

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.purple.shade600,
              Colors.deepPurpleAccent,
            ])),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: ToggleButtons(
                  children: const [
                    Padding(
                        padding: EdgeInsets.all(4),
                        child: Text("תספורת מסוג אחד")),
                    Padding(
                        padding: EdgeInsets.all(4),
                        child: Text("תספורת מסוג אחר"))
                  ],
                  isSelected: widget._isToggleSelected,
                  borderRadius: BorderRadius.circular(12),
                  borderWidth: 1,
                  color: Colors.white,
                  selectedColor: Colors.white,
                  selectedBorderColor: Colors.deepPurple,
                  borderColor: Colors.purpleAccent,
                  onPressed: (int index) => {
                        setState(() {
                          widget._isToggleSelected =
                              List.generate(2, (index) => false);
                          widget._isToggleSelected[index] = true;
                        })
                      }),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                margin: const EdgeInsets.only(top: 50),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
                  child: ListView.builder(
                    itemCount: widget
                        .times[widget._isToggleSelected
                            .indexWhere((element) => element)]
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 90,
                        margin: const EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            widget.times[widget._isToggleSelected
                                .indexWhere((element) => element)][index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purpleAccent.shade100,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
