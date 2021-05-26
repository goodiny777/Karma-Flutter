import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactWidget extends StatefulWidget {
  var _padding = 10.0;

  ContactWidget({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<ContactWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          leading: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () => {Navigator.pop(context)}),
          title: Text(
            'Contact Us',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              decoration: new InputDecoration(hintText: "Email"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              textAlign: TextAlign.center,
              decoration: new InputDecoration(hintText: "Topic"),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 100,
              clipBehavior: Clip.none,
              child: TextField(
                  textAlign: TextAlign.center,
                  minLines: 10,
                  maxLines: 10,
                  decoration: new InputDecoration(hintText: "Desctiption")),
            ),
            SizedBox(
              height: 8,
            ),
            OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Colors.deepOrangeAccent),
              ),
              child: Text('SEND',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
