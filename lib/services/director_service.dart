import '../helpers/database_helper.dart';
import '../models/director_model.dart';

class DirectorService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
  Future<int> insertDirector(Director director) async {
    final db = await _databaseHelper.database;
    return await db.insert('directors', director.toMap());
  }

  Future<Director?> getDirectorById(String id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'directors',
      where: 'identification = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Director.fromMap(maps.first);
    }
    return null;
  }
}
