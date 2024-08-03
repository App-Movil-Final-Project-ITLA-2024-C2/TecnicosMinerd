import 'package:flutter/material.dart';

class NavigationUtils {
  // Método para navegar a una página dada
  static void navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  // Método para navegar a una página dada y reemplazar la página actual
  static void navigateAndReplace(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}