import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:karma/general/db.dart';
import 'package:karma/models/alarm.dart';

// ignore: must_be_immutable
class AlarmDialog extends StatefulWidget {
  final Function(int) onConfirm;
  final double _padding = 30.0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final DBProvider _dbProvider = DBProvider.db;
  DateTime dateTime = DateTime.now();
  Color themeColor = Colors.lightGreen;

  AlarmDialog({Key key, this.onConfirm}) : super(key: key);

  @override
  _AlarmDialogState createState() => _AlarmDialogState();
}

class _AlarmDialogState extends State<AlarmDialog> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: widget.themeColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: contentBox(context),
        ),
      ),
    );
  }

  setDate(DateTime date) {
    widget.dateTime = date;
    widget._dateController.text = date.toIso8601String().split("T")[0];
  }

  setBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: widget.themeColor),
        borderRadius: BorderRadius.all(Radius.circular(20.0)));
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 320,
          padding: EdgeInsets.only(
              left: 20,
              top: widget._padding,
              right: 20,
              bottom: widget._padding),
          margin: EdgeInsets.only(top: widget._padding),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(widget._padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: widget._nameController,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                      enabledBorder: setBorder(),
                      border: setBorder(),
                      hintText: "Reminder title"),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  child: TextField(
                    controller: widget._dateController,
                    enableInteractiveSelection: false,
                    textAlign: TextAlign.center,
                    enabled: false,
                    style: TextStyle(),
                    textInputAction: TextInputAction.next,
                    decoration: new InputDecoration(
                        disabledBorder: setBorder(),
                        border: setBorder(),
                        hintText: "Reminder time",
                        hintStyle: TextStyle(color: Colors.black54)),
                  ),
                  onTap: () {
                    setDate(DateTime.now());
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext builder) {
                          return Container(
                              height: MediaQuery.of(context)
                                      .copyWith()
                                      .size
                                      .height /
                                  3,
                              child: CupertinoDatePicker(
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (DateTime newDate) {
                                  setDate(newDate);
                                },
                                mode: CupertinoDatePickerMode.time,
                              ));
                        });
                  },
                ),
                SizedBox(height: 60),
                OutlineButton(
                  padding: EdgeInsets.all(0.0),
                  color: Colors.white,
                  highlightElevation: 4,
                  borderSide: BorderSide.none,
                  onPressed: () {
                    if (widget._nameController.text.isNotEmpty &&
                        widget.dateTime != null) {
                      widget._dbProvider
                          .insertAlarm(AlarmInfo(
                              title: widget._nameController.text,
                              alarmDateTime: widget.dateTime,
                              isPending: true))
                          .then((value) => {
                                Navigator.pop(context),
                                widget.onConfirm.call(0)
                              });
                    } else {
                      Fluttertoast.showToast(
                          msg: "Missing info. Please fill all the fields",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Container(
                      width: 180,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(widget._padding),
                        color: widget.themeColor,
                      ),
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: Text('Add',
                          style: TextStyle(fontSize: 15, color: Colors.white))),
                )
              ],
            ),
          ),
        ),
        Positioned(
            left: 14,
            top: 44,
            child: GestureDetector(
              child: Icon(Icons.close),
              onTap: () {
                Navigator.pop(context);
              },
            ))
      ],
    );
  }
}
