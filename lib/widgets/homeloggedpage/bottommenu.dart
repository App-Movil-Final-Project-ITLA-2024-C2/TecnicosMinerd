import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/logged/demovideopage.dart';
import '../../pages/logged/visitsmaps.dart';
import '../../screens/homescreen.dart';
import '../../utils/navigation_util.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      color: Colors.blue[500],
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align items to the ends
        children: <Widget>[
            IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _logout(context); // Llama al método para cerrar sesión
            },
          ),
          IconButton(
            icon: const Icon(Icons.video_library),
            onPressed: () {
              NavigationUtils.navigateToPage(context, const DemoVideoPage());
            },
          ),
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              NavigationUtils.navigateToPage(context, const VisitsMapsPage());
            },
          ),
           IconButton(
            icon: const Icon(
              Icons.menu,
            ),
            onPressed: () {
              // Open the drawer
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sesión cerrada con éxito'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }

    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted) {
      NavigationUtils.navigateAndReplace(context, const MyHomeScreen());
    }  }
}
