import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutWidget extends StatefulWidget {
  AboutWidget({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<AboutWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.lime,
          leading: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () => {Navigator.pop(context)}),
          title: Text(
            'About',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                "Karma it is more than superstition and religion."
                "\nIt is about how people behave one to another."
                "\nIt is very important to me to give you a tool which can help you to count your good and bad deeds."
                "\nTo schedule and remind about it every day."
                "\nIn my opinion the men was created with the main purpose - to make good things to others."
                "\nThat is the way we can improve our world.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
