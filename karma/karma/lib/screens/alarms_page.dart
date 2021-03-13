import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:karma/general/db.dart';
import 'package:karma/models/alarm.dart';
import 'package:karma/views/alarm_dialog.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

import '../main.dart';

class AlarmsWidget extends StatefulWidget {
  AlarmsWidget({Key? key}) : super(key: key);

  final DBProvider db = DBProvider.db;

  @override
  _AlarmsState createState() => _AlarmsState();
}

class _AlarmsState extends State<AlarmsWidget> {
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
            'Alarms',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
      body: Column(
        children: [
          SizedBox(height: 8),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder<List<AlarmInfo>>(
                future: widget.db.getAlarms(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AlarmInfo>> snapshot) {
                  print(snapshot);
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        AlarmInfo? item = snapshot.data?[index];
                        return Dismissible(
                          background: Container(color: Colors.red),
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            setState(() {
                              widget.db.deleteAlarm(item?.id ?? -1);
                            });
                          },
                          child: GestureDetector(
                            child: Container(
                              height: 100,
                              margin: EdgeInsets.all(5),
                              child: ListTile(
                                title: Text(item?.description ?? ""),
                                subtitle: Text(
                                    "${item?.alarmDateTime?.hour}:${item?.alarmDateTime?.minute}"),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.lightBlue.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                            ),
                            onTap: () => {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlarmDialog(
                                        alarmInfo: item,
                                        onConfirm: (alarm) => {
                                              Future.delayed(
                                                  Duration(milliseconds: 500),
                                                  () {
                                                this.setState(() {});
                                                scheduleAlarm(alarm);
                                              })
                                            });
                                  }),
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlarmDialog(
                    alarmInfo: null,
                    onConfirm: (alarm) => {
                          Future.delayed(Duration(milliseconds: 500), () {
                            this.setState(() {});
                            scheduleAlarm(alarm);
                          })
                        });
              }),
        },
        child: Icon(Icons.alarm_add, color: Colors.white),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }

  void scheduleAlarm(AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notification',
      'alarm_notification',
      'Channel for Alarm notification',
      icon: '@drawable/ic_stat_icon',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    tz.initializeTimeZones();

    await notificationsPlugin.zonedSchedule(
        alarmInfo.id,
        'Karma',
        alarmInfo.description,
        TZDateTime.from(
            alarmInfo.alarmDateTime,
            tz.timeZoneDatabase.locations.values.firstWhere((element) =>
                element.currentTimeZone.offset.toInt() ==
                DateTime.now().timeZoneOffset.inMilliseconds)),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
