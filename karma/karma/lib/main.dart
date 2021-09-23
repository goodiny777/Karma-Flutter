import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'general/constants.dart';
import 'screens/home_page.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initializationAndroidSettings =
      AndroidInitializationSettings('@drawable/ic_stat_icon');
  var initializationIosSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationAndroidSettings, iOS: initializationIosSettings);
  await notificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    print(payload);
    if (payload != null) debugPrint(payload);
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Karma',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: materialAppLightGreen,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Sansation'),
        home: AnimatedSplashScreen(
            splash: Image.asset(
              "assets/images/icon.png",
              width: 500,
              height: 500,
            ),
            backgroundColor: materialAppLightGreen,
            nextScreen: MyHomePage()));
  }
}
