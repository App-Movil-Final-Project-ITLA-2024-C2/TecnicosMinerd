import '../helpers/database_helper.dart';
import '../models/visittype_model.dart';

class VisitTypeService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertVisitType(VisitType visitType) async {
    final db = await _databaseHelper.database;
    return await db.insert('visit_types', visitType.toMap());
  }

  Future<List<VisitType>> getVisitTypes() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('visit_types');
    return List.generate(maps.length, (i) {
      return VisitType.fromMap(maps[i]);
    });
  }
}
