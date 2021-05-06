import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fluttertoast/fluttertoast.dart';
import 'package:karma/general/db.dart';
import 'package:karma/models/alarm.dart';

// ignore: must_be_immutable
class AlarmDialog extends StatefulWidget {
  final Function(AlarmInfo)? onConfirm;
  final double _padding = 30.0;
  final double _radius = 16.0;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final DBProvider _dbProvider = DBProvider.db;
  DateTime dateTime = DateTime.now();
  Color themeColor = Colors.lightBlue;

  AlarmDialog({Key? key, AlarmInfo? alarmInfo, this.onConfirm}) : super(key: key);

  @override
  _AlarmDialogState createState() => _AlarmDialogState();
}

class _AlarmDialogState extends State<AlarmDialog> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.lightBlue,
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
    widget._dateController.text = "${date.hour}:${date.minute}";
  }

  setBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: widget.themeColor),
        borderRadius: BorderRadius.all(Radius.circular(widget._radius)));
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 350,
          padding: EdgeInsets.only(
              left: 20,
              top: widget._padding,
              right: 20,
              bottom: widget._padding),
          margin: EdgeInsets.only(top: widget._padding),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(widget._radius),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
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
                                use24hFormat: true,
                              ));
                        });
                  },
                ),
                SizedBox(height: 8),
                Container(
                  height: 100,
                  clipBehavior: Clip.none,
                  child: TextField(
                      controller: widget._descriptionController,
                      textAlign: TextAlign.center,
                      minLines: 10,
                      maxLines: 10,
                      textInputAction: TextInputAction.done,
                      decoration: new InputDecoration(
                          enabledBorder: setBorder(),
                          border: setBorder(),
                          hintText: "Reminder description")),
                ),
                SizedBox(height: 30),
                OutlinedButton(
                  onPressed: () {
                    if (widget._dateController.text.isNotEmpty &&
                        widget.dateTime != null) {
                      var alarm = AlarmInfo(
                          description: widget._descriptionController.text,
                          alarmDateTime: widget.dateTime,
                          isPending: true);
                      widget._dbProvider
                          .insertAlarm(alarm)
                          .then((value) => {
                                Navigator.pop(context),
                                alarm.id = value,
                                widget.onConfirm?.call(alarm)
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
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(widget._radius)),
                      backgroundColor: widget.themeColor),
                  child: Container(
                      height: 80,
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
