import 'package:tecnicos_minerd/helpers/database_helper.dart';
import 'package:tecnicos_minerd/models/director_model.dart';
import 'package:tecnicos_minerd/models/school_model.dart';

class DatabaseService {
  static final DatabaseHelper _dbHelper = DatabaseHelper();

  static Future<Director?> getDirectorByIdentification(String identification) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'directors',
      where: 'identification = ?',
      whereArgs: [identification],
    );

    if (maps.isNotEmpty) {
      return Director.fromMap(maps.first);
    }
    return null;
  }

  static Future<School?> getSchoolByCode(String code) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'schools',
      where: 'code = ?',
      whereArgs: [code],
    );

    if (maps.isNotEmpty) {
      return School.fromMap(maps.first);
    }
    return null;
  }
}