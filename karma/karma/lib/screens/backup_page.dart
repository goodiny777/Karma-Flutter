import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class BackupWidget extends StatefulWidget {
  var _padding = 10.0;

  BackupWidget({Key? key}) : super(key: key);

  @override
  _BackupState createState() => _BackupState();
}

class _BackupState extends State<BackupWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.purple.shade300,
          leading: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onTap: () => {Navigator.pop(context)}),
          title: Text(
            'Backup',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              onPressed: () {},
              child: Text("Load from local storage"),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {},
              child: Text("Load from external storage"),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {},
              child: Text("Backup to local storage"),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {},
              child: Text("Backup to external storage"),
            ),
          ],
        ),
      ),
    );
  }
}
