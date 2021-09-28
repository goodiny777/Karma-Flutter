import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BuildContext? mainContext;

var screenWidth = MediaQuery.of(mainContext!).size.width;
var screenHeight = MediaQuery.of(mainContext!).size.height;

const materialAppDarkGreen = MaterialColor(
  0xff042707,
  <int, Color>{
    50: Color(0xFFB6F7BB),
    100: Color(0xFF12A51F),
    200: Color(0xFF0A5C11),
    300: Color(0xFF08490E),
    400: Color(0xFF06370A),
    500: Color(0xff042707),
    600: Color(0xFF021203),
    700: Color(0xFF021203),
    800: Color(0xFF021203),
    900: Color(0xFF021203),
  },
);

const materialAppLightGreen = MaterialColor(0xff79871d, <int, Color>{
  50: Color(0xFFe4edab),
  100: Color(0xFFd4e278),
  200: Color(0xFFc4d846),
  300: Color(0xFFb5ca2b),
  400: Color(0xFF97a824),
  500: Color(0xff79871d),
  600: Color(0xFF5a6515),
  700: Color(0xFF4b5412),
  800: Color(0xFF3c430e),
  900: Color(0xFF1e2207),
});

const materialAppYellow = MaterialColor(0xffFBE00F, <int, Color>{
  50: Color(0xFFfef7c3),
  100: Color(0xFFfdf29f),
  200: Color(0xFFfded72),
  300: Color(0xFFfce74a),
  400: Color(0xFFfce536),
  500: Color(0xffFBE00F),
  600: Color(0xFFddc404),
  700: Color(0xFFb5a003),
  800: Color(0xFF796b09),
  900: Color(0xFF3c3501),
});
