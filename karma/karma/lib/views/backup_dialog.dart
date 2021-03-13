import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BackupDialog extends StatefulWidget {
  final String? title, descriptions, text;
  final Image? img;
  final double _padding = 20.0;

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
          padding: EdgeInsets.only(
              left: widget._padding,
              top: widget._padding,
              right: widget._padding,
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
              OutlineButton(
                padding: EdgeInsets.all(0.0),
                color: Colors.white,
                borderSide: BorderSide.none,
                onPressed: () {},
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(widget._padding),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.lightGreen,
                        Colors.lightGreenAccent
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Text('Gradient Button',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.all(0.0),
                    color: Colors.white,
                    borderSide: BorderSide.none,
                    onPressed: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(widget._padding),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.lightGreen,
                            Colors.lightGreenAccent
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: Text('Gradient Button',
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                    ),
                  ),
                  OutlineButton(
                    padding: EdgeInsets.all(0.0),
                    color: Colors.white,
                    borderSide: BorderSide.none,
                    onPressed: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(widget._padding),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.lightGreen,
                            Colors.lightGreenAccent
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: Text('Gradient Button',
                          style: TextStyle(fontSize: 12, color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
            left: 10,
            top: 30,
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
