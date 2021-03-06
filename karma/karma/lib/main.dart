import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'screens/home_page.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationAndroidSettings =
      AndroidInitializationSettings("defaultIcon");
  var initializationIosSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(android: initializationAndroidSettings, iOS: initializationIosSettings);
  await notificationsPlugin.initialize(initializationSettings, onSelectNotification: (String payload) async {
    if(payload != null)
      debugPrint(payload);
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Karma',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AnimatedSplashScreen(
            splash: Image.asset(
              "assets/images/icon.png",
              width: 500,
              height: 500,
            ),
            backgroundColor: Colors.lightGreen,
            nextScreen: MyHomePage()));
  }
}
