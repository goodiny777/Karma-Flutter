import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karma/screens/alarms_page.dart';
import 'package:karma/screens/statistics_page.dart';

import '../dialogs/backup_dialog.dart';
import '../dialogs/contact_us_dialog.dart';

Widget getDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Row(children: [
            Image(
              image: AssetImage("assets/images/icon.png"),
            ),
            Text(
              'Karma',
              style: TextStyle(color: Colors.white, fontSize: 24),
            )
          ]),
          decoration: BoxDecoration(
            color: Colors.lightGreen,
          ),
        ),
        ListTile(
          leading: Image(
            image: AssetImage("assets/images/statistics.png"),
            width: 25,
            height: 25,
          ),
          title: Text("Statistics"),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => StatisticsWidget()));
          },
        ),
        ListTile(
          leading: Image(
            image: AssetImage("assets/images/alarm.png"),
            width: 25,
            height: 25,
          ),
          title: Text("Alarms"),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AlarmsWidget()));
          },
        ),
        ListTile(
          leading: Image(
            image: AssetImage("assets/images/share.png"),
            width: 25,
            height: 25,
          ),
          title: Text("Share app"),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Image(
            image: AssetImage("assets/images/backup.png"),
            width: 25,
            height: 25,
          ),
          title: Text("Backup"),
          onTap: () {
            Navigator.pop(context);
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return BackupDialog();
                });
          },
        ),
        ListTile(
          leading: Image(
            image: AssetImage("assets/images/email.png"),
            width: 25,
            height: 25,
          ),
          title: Text("Contact us"),
          onTap: () {
            Navigator.pop(context);
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return ContactUsDialog();
                });
          },
        ),
        ListTile(
          leading: Image(
            image: AssetImage("assets/images/about.png"),
            width: 25,
            height: 25,
          ),
          title: Text("About"),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
