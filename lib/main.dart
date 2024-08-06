import 'package:flutter/material.dart';

import 'screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define los colores que usarás en la aplicación
    var appBarBgColor = Colors.blue[900];
    var appBarTextColor = Colors.white;
    var bodytextColor = Colors.black;
    var bodybgColor = Colors.white;
    var accentColor = Colors.red[900];  
    var cardColor = Colors.grey[50]; // Color para las cartas

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
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w300,
            fontSize: 18,
          ),
        ),
        iconTheme: IconThemeData(color: appBarTextColor),
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
        cardTheme: CardTheme(
          color: cardColor, // Color de fondo de las cartas
        ),
        useMaterial3: true,
      ),
      home: const MyHomeScreen(),
    );
  }
}
