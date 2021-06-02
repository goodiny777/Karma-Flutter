import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karma/general/constants.dart';
import 'package:karma/screens/about_page.dart';
import 'package:karma/screens/alarms_page.dart';
import 'package:karma/screens/backup_page.dart';
import 'package:karma/screens/contact_page.dart';
import 'package:karma/screens/statistics_page.dart';

Widget getDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Image(
            image: AssetImage("assets/images/karma_banner.jpg"),
          ),
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: appGreen,
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
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => BackupWidget()));
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
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ContactWidget()));
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
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AboutWidget()));
          },
        ),
      ],
    ),
  );
}
