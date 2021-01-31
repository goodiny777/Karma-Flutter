import 'package:flutter/material.dart';
import 'package:karma/general/db.dart';
import 'package:karma/models/deed.dart';
import 'package:karma/screens/statistics.dart';
import 'package:karma/views/backup_dialog.dart';
import 'package:karma/views/contact_us_dialog.dart';
import 'package:karma/views/deed_dialog.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final DBProvider _dbProvider = DBProvider.db;
  bool canAction = true;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: widget._drawerKey,
        drawer: Drawer(
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StatisticsWidget()));
                },
              ),
              // ListTile(
              //   leading: Image(
              //     image: AssetImage("assets/images/alarm.png"),
              //     width: 25,
              //     height: 25,
              //   ),
              //   title: Text("Alarms"),
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.of(context).push(
              //         MaterialPageRoute(builder: (context) => AlarmsWidget()));
              //   },
              // ),
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
        ),
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              alignment: Alignment.centerRight,
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                widget._drawerKey.currentState.openDrawer();
              }),
        ),
        body: FutureBuilder<List<Deed>>(
          future: widget._dbProvider.getAllDeeds(),
          builder: (BuildContext context, AsyncSnapshot<List<Deed>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Deed item = snapshot.data[index];
                  Color color;
                  String deedTitle;
                  if (item.type) {
                    deedTitle = "Good deed";
                    color = Colors.lightGreenAccent;
                  } else {
                    deedTitle = "Bad deed";
                    color = Colors.redAccent;
                  }
                  return Dismissible(
                    background: Container(color: Colors.red),
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      widget._dbProvider.deleteDeed(item.id);
                    },
                    child: Container(
                      height: 100,
                      margin: EdgeInsets.all(5),
                      child: ListTile(
                        title: Text(deedTitle),
                        isThreeLine: true,
                        subtitle: Text(
                            "${item.description}\n${item.date.hour}:${item.date.minute}"),
                      ),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Colors.redAccent,
                heroTag: "btn",
                onPressed: () => {
                  if (widget.canAction)
                    {
                      widget.canAction = false,
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return DeedDialog(
                                type: false,
                                onConfirm: () => {
                                      Future.delayed(Duration(seconds: 1), () {
                                        setState(() {});
                                        widget.canAction = true;
                                      }),
                                    });
                          }),
                    }
                },
                child: Icon(Icons.remove_circle_outline_outlined,
                    color: Colors.white),
              ),
              SizedBox(
                width: 200,
              ),
              FloatingActionButton(
                backgroundColor: Colors.lightGreen,
                heroTag: "btn2",
                onPressed: () => {
                  if (widget.canAction)
                    {
                      widget.canAction = false,
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return DeedDialog(
                                type: true,
                                onConfirm: () => {
                                      Future.delayed(Duration(seconds: 1), () {
                                        setState(() {});
                                        widget.canAction = true;
                                      }),
                                    });
                          }),
                    }
                },
                child: Icon(Icons.add_circle_outline, color: Colors.white),
              )
            ],
          ),
        ));
  }
}
