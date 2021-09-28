import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:karma/dialogs/deed_dialog.dart';
import 'package:karma/general/constants.dart';
import 'package:karma/general/db.dart';
import 'package:karma/models/deed.dart';
import 'package:karma/widgets/drawer.dart';
import 'package:karma/widgets/semi_circle.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final DBProvider _dbProvider = DBProvider.db;
  bool canAction = true;
  PageController? _pageController;
  List<DateTime?>? datesList;
  DateTime? selectedDate;
  int lastDatePosition = 0;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const fabSide = 80.0;

  @override
  void initState() {
    updateDatesList();
    super.initState();
  }

  void updateDatesList() {
    widget._dbProvider
        .getAllDates()
        .then((value) => {
              widget.datesList = value,
              widget.selectedDate =
                  value.length > 0 ? value[widget.lastDatePosition] : null,
              widget._pageController = PageController(),
              widget._pageController?.addListener(() {
                updateDeedsList();
              })
            })
        .whenComplete(() => setState(() {}));
  }

  void updateDeedsList() {
    setState(() {
      if (widget.datesList?.isNotEmpty == true &&
          widget._pageController?.page?.toInt() != widget.lastDatePosition) {
        widget.lastDatePosition = widget._pageController?.page?.toInt() ?? 0;
        widget.selectedDate = widget.datesList?[widget.lastDatePosition];
      }
    });
  }

  @override
  void dispose() {
    widget._pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mainContext = context;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: widget._drawerKey,
      drawer: getDrawer(context),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              widget._drawerKey.currentState?.openDrawer();
            }),
      ),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.1,
            width: screenWidth,
            child: FutureBuilder<List<DateTime?>>(
              future: widget._dbProvider.getAllDates(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<DateTime?>> snapshot) {
                return PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: widget._pageController,
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    DateTime? item = snapshot.data?[index];
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                        title: Center(
                          child: Text(
                            "${(item?.day ?? 0) < 10 ? "0" + (item?.day.toString() ?? "") : item?.day} ${(item?.month ?? 0) < 10 ? "0" + (item?.month.toString() ?? "") : (item?.month ?? 0)} ${(item?.year ?? 0)}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        leading: Icon(Icons.arrow_back_ios),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              child: FutureBuilder<List<Deed>>(
                future:
                    widget._dbProvider.getAllDeedsForDate(widget.selectedDate),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Deed>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        Deed? item = snapshot.data?[index];
                        Color color;
                        String imagePath;
                        String? deedTitle;
                        deedTitle = item?.name;
                        if (item?.type == true) {
                          imagePath = "assets/images/good.png";
                          color = materialAppLightGreen;
                        } else {
                          imagePath = "assets/images/bad.png";
                          color = materialAppYellow;
                        }
                        return Dismissible(
                          background: Container(color: Colors.red),
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            setState(() {
                              widget._dbProvider.deleteDeed(item?.id ?? -1);
                            });
                          },
                          child: Container(
                            height: 120,
                            margin: EdgeInsets.all(5),
                            child: ListTile(
                              title: Text(
                                "Title: $deedTitle",
                                style: TextStyle(fontSize: 20),
                              ),
                              leading: Image(
                                image: AssetImage(imagePath),
                                color: color,
                              ),
                              trailing: Text("Deed evaluation: ${item?.value}",
                                  style: TextStyle(fontSize: 16)),
                              isThreeLine: true,
                              subtitle: Text(
                                "Time: ${item?.date?.hour}:${item?.date?.minute}"
                                "\nDescription: ${item?.description}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: color.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
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
            ),
          ),
          Container(
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                SemiCircle(),
                Positioned(
                  child: fab(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fab() {
    return Container(
      width: fabSide,
      height: fabSide,
      child: FloatingActionButton(
        backgroundColor: materialAppLightGreen,
        heroTag: "btnGood",
        onPressed: () => {
          if (widget.canAction)
            {
              widget.canAction = false,
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return DeedDialog(
                        onConfirm: () => {
                              updateOnDeedAdded(),
                            });
                  }),
              Future.delayed(Duration(seconds: 1), () {
                widget.canAction = true;
              }),
            }
        },
        child: Icon(Icons.add_rounded, color: Colors.white),
      ),
    );
  }

  void updateOnDeedAdded() {
    Future.delayed(Duration(milliseconds: 500), () {
      this.setState(() {
        updateDatesList();
      });
    });
  }
}

class CustomScrollPhysics extends FixedExtentScrollPhysics {
  const CustomScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  double get minFlingVelocity => double.infinity;

  @override
  double get maxFlingVelocity => double.infinity;

  @override
  double get minFlingDistance => double.infinity;

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }
}
