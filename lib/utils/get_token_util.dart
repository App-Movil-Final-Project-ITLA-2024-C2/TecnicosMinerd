import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenUtil {

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString('user');
      if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        return userMap['token'];
      }
      return null;
  }
}