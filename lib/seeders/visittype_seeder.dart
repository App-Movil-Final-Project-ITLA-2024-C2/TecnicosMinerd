import 'package:sqflite/sqflite.dart';

class VisitTypeSeeder {
  static Future<void> seed(Database db) async {
    List<Map<String, dynamic>> visitTypes = [
      {
        'name': 'Visita de Supervisión',
        'description': 'Supervisión general de las actividades escolares.'
      },
      {
        'name': 'Visita de Evaluación',
        'description': 'Evaluación del desempeño de los docentes.'
      },
    ];

    for (var visitType in visitTypes) {
      await db.insert('visit_types', visitType);
    }
  }
}
