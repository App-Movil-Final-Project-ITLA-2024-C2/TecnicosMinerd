
import '../helpers/database_helper.dart';
import '../models/visit_model.dart';

class VisitService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertVisit(Visit visit) async {
    final db = await _databaseHelper.database;
    return await db.insert('visits', visit.toMap());
  }

  Future<List<Visit>> getVisits() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('visits');
    return List.generate(maps.length, (i) {
      return Visit.fromMap(maps[i]);
    });
  }

  Future<Visit?> getVisitById(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'visits',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Visit.fromMap(maps.first);
    }
    return null;
  }
}
