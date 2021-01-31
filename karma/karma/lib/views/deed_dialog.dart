import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karma/general/db.dart';
import 'package:karma/models/deed.dart';

// ignore: must_be_immutable
class DeedDialog extends StatefulWidget {
  final bool type;
  final Function() onConfirm;
  final double _padding = 30.0;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final DBProvider _dbProvider = DBProvider.db;
  DateTime dateTime;
  Color themeColor = Colors.red;
  List<Color> _btnGradient = [
    Colors.red.shade100,
    Colors.red,
    Colors.red.shade100
  ];

  DeedDialog({Key key, this.type, this.onConfirm}) : super(key: key);

  @override
  _DeedDialogState createState() => _DeedDialogState();
}

class _DeedDialogState extends State<DeedDialog> {
  @override
  Widget build(BuildContext context) {
    if (widget.type) {
      widget.themeColor = Colors.lightGreen;
      widget._btnGradient = [
        Colors.lightGreen.shade100,
        Colors.lightGreen,
        Colors.lightGreen.shade100
      ];
    }

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

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    hintText: "Name"),
              ),
              SizedBox(height: 8),
              GestureDetector(
                child: TextField(
                  controller: widget._dateController,
                  enabled: false,
                  textAlign: TextAlign.center,
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      hintText: "Date"),
                ),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext builder) {
                        return Container(
                            height:
                                MediaQuery.of(context).copyWith().size.height /
                                    3,
                            child: CupertinoDatePicker(
                              initialDateTime: DateTime.now(),
                              onDateTimeChanged: (DateTime newDate) {
                                setState(() {
                                  widget.dateTime = newDate;
                                  widget._dateController.text =
                                      newDate.toIso8601String().split("T")[0];
                                });
                              },
                              minimumYear: 2000,
                              maximumYear: 2035,
                              mode: CupertinoDatePickerMode.date,
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
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        hintText: "Description")),
              ),
              SizedBox(height: 8),
              OutlineButton(
                padding: EdgeInsets.all(0.0),
                color: Colors.white,
                highlightElevation: 4,
                borderSide: BorderSide.none,
                onPressed: () {
                  widget._dbProvider.newDeed(Deed(
                      id: 1,
                      description: widget._descriptionController.text,
                      type: widget.type,
                      value: 5,
                      date: widget.dateTime));
                  widget.onConfirm();
                  Navigator.pop(context);
                },
                child: Container(
                    width: 180,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(widget._padding),
                      gradient: LinearGradient(
                        colors: widget._btnGradient,
                      ),
                    ),
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: Text('Add',
                        style: TextStyle(fontSize: 15, color: Colors.white))),
              )
            ],
          ),
        ),
        Positioned(
            left: 10,
            top: 36,
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
