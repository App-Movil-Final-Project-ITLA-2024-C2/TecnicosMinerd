import 'package:sqflite/sqflite.dart';

class UserSeeder {
  static Future<void> seed(Database db) async {
    List<Map<String, dynamic>> users = [
      {'username': 'tecnico1', 'password': 'password1'},
      {'username': 'tecnico2', 'password': 'password2'},
    ];

    for (var user in users) {
      await db.insert('users', user);
    }
  }
}
