import '../helpers/database_helper.dart';
import '../models/incident_model.dart';

class IncidentService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertIncident(Incident incident) async {
    final db = await _databaseHelper.database;
    return await db.insert('incidents', incident.toMap());
  }

  Future<List<Incident>> getIncidents() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'incidents',
      orderBy: 'id DESC',
    );
    
    return List.generate(maps.length, (i) {
      return Incident.fromMap(maps[i]);
    });
  }

  Future<Incident?> getIncidentById(int id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'incidents',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Incident.fromMap(maps.first);
    }
    return null;
  }

  Future<void> deleteAllIncidents() async {
    final db = await _databaseHelper.database;
    await db.delete('incidents');
  }
}
