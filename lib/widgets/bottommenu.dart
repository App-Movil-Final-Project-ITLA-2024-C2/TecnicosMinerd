import 'package:flutter/material.dart';

import '../pages/aboutpage.dart';
import '../pages/deletepage.dart';
import '../pages/loginpage.dart';
import '../utils/navigation_util.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () {
              NavigationUtils.navigateToPage(context, const DeletePage());
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.info,
            ),
            onPressed: () {
              NavigationUtils.navigateToPage(context, const AboutPage());
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.info,
            ),
            onPressed: () {
              NavigationUtils.navigateToPage(context, const AboutPage());
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.login,
            ),
            onPressed: () {
              NavigationUtils.navigateToPage(context, const LoginPage());
            },
          ),
        ],
      ),
    );
  }
}