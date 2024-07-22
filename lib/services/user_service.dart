import '../helpers/database_helper.dart';
import '../models/user_model.dart';

class UserService {
  
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<User?> authenticate(String username, String password) async {
    final db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }

    return null;
  }

}
