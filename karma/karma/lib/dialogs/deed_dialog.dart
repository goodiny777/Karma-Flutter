import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:karma/general/constants.dart';
import 'package:karma/general/db.dart';
import 'package:karma/models/deed.dart';

// ignore: must_be_immutable
class DeedDialog extends StatefulWidget {
  final Function()? onConfirm;
  final double _padding = 10.0;
  final double _radius = 12.0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final DBProvider _dbProvider = DBProvider.db;
  List<bool> _isToggleSelected = List.generate(3, (index) => false);
  DateTime dateTime = DateTime.now();
  double _currentSliderValue = 5.0;

  DeedDialog({Key? key, this.onConfirm}) : super(key: key);

  @override
  _DeedDialogState createState() => _DeedDialogState();
}

class _DeedDialogState extends State<DeedDialog> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: materialAppYellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      child: Dialog(
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
        borderSide: BorderSide(color: materialAppYellow),
        borderRadius: BorderRadius.all(Radius.circular(widget._radius)));
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          height: screenHeight * 0.7,
          width: screenWidth * 0.96,
          padding: EdgeInsets.only(
              left: 20,
              top: widget._padding,
              right: 20,
              bottom: widget._padding),
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
                      valueIndicatorColor: materialAppYellow,
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
                SizedBox(height: 20),
                Container(
                    height: 30,
                    child: ToggleButtons(
                        children: [
                          Text("Good"),
                          Text("Irrelevant"),
                          Text("Bad")
                        ],
                        isSelected: widget._isToggleSelected,
                        borderRadius: BorderRadius.circular(12),
                        borderWidth: 1,
                        selectedColor: materialAppLightGreen,
                        selectedBorderColor: materialAppLightGreen,
                        borderColor: materialAppYellow,
                        onPressed: (int index) => {
                              setState(() {
                                widget._isToggleSelected = List.generate(3, (index) => false);
                                widget._isToggleSelected[index] = true;
                              })
                            })),
                SizedBox(height: 60),
                OutlinedButton(
                  onPressed: () {
                    if (widget._descriptionController.text.isNotEmpty &&
                        widget._nameController.text.isNotEmpty) {
                      widget._dbProvider.newDeed(Deed(
                          name: widget._nameController.text,
                          description: widget._descriptionController.text,
                          type: true,
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
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(widget._radius)),
                      backgroundColor: materialAppYellow),
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
            left: 10,
            top: 10,
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
