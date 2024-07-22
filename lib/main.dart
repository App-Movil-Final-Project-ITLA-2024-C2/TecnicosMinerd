import 'package:flutter/material.dart';

import 'pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    var appBarBgColor = Colors.blue[900];
    var appBarTextColor = Colors.white;
    var bodytextColor = Colors.black;
    var bodybgColor = Colors.white;
    var accentColor = Colors.red[900];

    return MaterialApp(
      title: 'Tecnicos MINERD',
      theme: ThemeData(
        primaryColor: bodytextColor,
        scaffoldBackgroundColor: bodybgColor,
        appBarTheme: AppBarTheme(
          foregroundColor: appBarTextColor,
          backgroundColor: appBarBgColor, 
          iconTheme: IconThemeData(color: accentColor),
          ),
        iconTheme: IconThemeData(color: appBarBgColor), // Color de los íconos en general
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: appBarBgColor,
          foregroundColor: appBarTextColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(appBarBgColor),
            foregroundColor: WidgetStateProperty.all(bodytextColor),
          ),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

