import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karma/general/constants.dart';

class BackupDialog extends StatefulWidget {
  final String? title, descriptions, text;
  final Image? img;
  final double _padding = 10.0;

  const BackupDialog(
      {Key? key, this.title, this.descriptions, this.text, this.img})
      : super(key: key);

  @override
  _BackupDialogState createState() => _BackupDialogState();
}

class _BackupDialogState extends State<BackupDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget._padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.only(
              left: widget._padding,
              top: widget._padding,
              right: widget._padding,
              bottom: widget._padding),
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
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(widget._padding)),
                      backgroundColor: materialAppLightGreen),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                    ),
                    child: Text('Gradient Button',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(widget._padding)),
                          backgroundColor: materialAppLightGreen),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: Text('Gradient Button',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                    ),
                    SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(widget._padding)),
                          backgroundColor: materialAppLightGreen),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                        ),
                        child: Text('Gradient Button',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 10,
          top: 20,
          child: GestureDetector(
            child: Icon(Icons.close),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
