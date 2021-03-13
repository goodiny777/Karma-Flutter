import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:karma/general/db.dart';
import 'package:karma/models/deed.dart';

// ignore: must_be_immutable
class DeedDialog extends StatefulWidget {
  final bool? type;
  final Function()? onConfirm;
  final double _padding = 30.0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final DBProvider _dbProvider = DBProvider.db;
  DateTime dateTime = DateTime.now();
  Color themeColor = Colors.red;
  double _currentSliderValue = 5.0;

  DeedDialog({Key? key, this.type, this.onConfirm}) : super(key: key);

  @override
  _DeedDialogState createState() => _DeedDialogState();
}

class _DeedDialogState extends State<DeedDialog> {
  @override
  Widget build(BuildContext context) {
    if (widget.type == true) {
      widget.themeColor = Colors.lightGreen;
    }

    return Theme(
      data: ThemeData(
        primarySwatch: widget.themeColor as MaterialColor,
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
          height: 520,
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
                      hintText: "Title"),
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
                        hintText: "Date",
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
                                minimumYear: 2000,
                                maximumYear: 2035,
                                mode: CupertinoDatePickerMode.date,
                              ));
                        });
                  },
                ),
                SizedBox(height: 8),
                SliderTheme(
                  data: SliderThemeData(
                      valueIndicatorColor: widget.themeColor,
                      valueIndicatorTextStyle: TextStyle(color: Colors.white)),
                  child: Slider(
                      value: widget._currentSliderValue,
                      min: 0,
                      max: 10,
                      divisions: 10,
                      label: widget._currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          widget._currentSliderValue = value;
                        });
                      }),
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
                          hintText: "Description")),
                ),
                SizedBox(height: 80),
                OutlineButton(
                  padding: EdgeInsets.all(0.0),
                  color: Colors.white,
                  highlightElevation: 4,
                  borderSide: BorderSide.none,
                  onPressed: () {
                    if (widget._descriptionController.text.isNotEmpty &&
                        widget.dateTime != null &&
                        widget._nameController.text.isNotEmpty) {
                      widget._dbProvider.newDeed(Deed(
                          name: widget._nameController.text,
                          description: widget._descriptionController.text,
                          type: widget.type,
                          value: widget._currentSliderValue.toInt(),
                          date: widget.dateTime));
                      Navigator.pop(context);
                      widget.onConfirm?.call();
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
