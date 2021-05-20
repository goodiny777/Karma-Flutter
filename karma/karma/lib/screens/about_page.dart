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
          children: [],
        ));
  }
}
