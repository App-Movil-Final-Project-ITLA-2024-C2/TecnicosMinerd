
import '../helpers/database_helper.dart';
import '../models/school_model.dart';

class SchoolService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
  Future<int> insertSchool(School school) async {
    final db = await _databaseHelper.database;
    return await db.insert('schools', school.toMap());
  }

  Future<School?> getSchoolByCode(String code) async {
    final db = await _databaseHelper.database;
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
