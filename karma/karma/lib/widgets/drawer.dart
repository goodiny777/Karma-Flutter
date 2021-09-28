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
            color: materialAppDarkGreen,
          ),
        ),
        ListTile(
          leading: Image(
            image: AssetImage("assets/images/statistics.png"),
            width: 25,
            height: 25,
            color: materialAppLightGreen,
          ),
          title: Text(
            "Statistics",
            style: TextStyle(color: materialAppLightGreen),
          ),
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
            color: materialAppLightGreen,
          ),
          title: Text(
            "Alarms",
            style: TextStyle(color: materialAppLightGreen),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AlarmsWidget()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.queue_music_rounded,
            color: materialAppLightGreen,
            size: 25.0,
          ),
          title: Text(
            "Music",
            style: TextStyle(color: materialAppLightGreen),
          ),
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
            color: materialAppLightGreen,
          ),
          title: Text(
            "Share app",
            style: TextStyle(color: materialAppLightGreen),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Image(
            image: AssetImage("assets/images/backup.png"),
            width: 25,
            height: 25,
            color: materialAppLightGreen,
          ),
          title: Text(
            "Backup",
            style: TextStyle(color: materialAppLightGreen),
          ),
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
            color: materialAppLightGreen,
          ),
          title: Text(
            "Contact us",
            style: TextStyle(color: materialAppLightGreen),
          ),
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
            color: materialAppLightGreen,
          ),
          title: Text(
            "About",
            style: TextStyle(color: materialAppLightGreen),
          ),
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
