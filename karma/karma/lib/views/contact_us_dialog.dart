import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactUsDialog extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;
  final double _padding = 26.0;

  const ContactUsDialog(
      {Key key, this.title, this.descriptions, this.text, this.img})
      : super(key: key);

  @override
  _ContactUsDialogState createState() => _ContactUsDialogState();
}

class _ContactUsDialogState extends State<ContactUsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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
              TextField(
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                    border: OutlineInputBorder(), hintText: "Email"),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                textAlign: TextAlign.center,
                decoration: new InputDecoration(
                    border: OutlineInputBorder(), hintText: "Topic"),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 100,
                clipBehavior: Clip.none,
                child: TextField(
                    textAlign: TextAlign.center,
                    minLines: 10,
                    maxLines: 10, decoration: new InputDecoration(
                        border: OutlineInputBorder(), hintText: "Desctiption")),
              ),
              SizedBox(
                height: 8,
              ),
              OutlineButton(
                padding: EdgeInsets.all(0.0),
                color: Colors.white,
                borderSide: BorderSide.none,
                onPressed: () {},
                child: Container(
                  width: 120,
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
                  alignment: Alignment.center,
                  child: Text('Send',
                      style: TextStyle(fontSize: 14, color: Colors.white)),
                ),
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
