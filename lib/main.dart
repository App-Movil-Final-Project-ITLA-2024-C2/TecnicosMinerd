import 'package:flutter/material.dart';

import 'screens/homescreen.dart';

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
          titleTextStyle: const TextStyle(
            fontFamily: 'Roboto', // Cambia por la fuente deseada
            fontWeight: FontWeight.w300, // Estilo de fuente fina
            fontSize: 18, // Tamaño de fuente opcional
          ),
        ),
        iconTheme: IconThemeData(color: appBarTextColor), // Color de los íconos en general
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: appBarBgColor,
          foregroundColor: appBarTextColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(appBarBgColor),
            foregroundColor: WidgetStateProperty.all(appBarTextColor),
          ),
        ),
        useMaterial3: true,
      ),
      home: const MyHomeScreen(),
    );
  }
}
