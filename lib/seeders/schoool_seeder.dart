import 'package:sqflite/sqflite.dart';

class SchoolSeeder {
  static Future<void> seed(Database db) async {
    List<Map<String, dynamic>> schools = [
      {
        'code': 'ESC-001',
        'name': 'Escuela Primaria 1',
        'address': 'Calle 1, Ciudad 1',
        'phone_number': '809-123-4567'
      },
      {
        'code': 'ESC-002',
        'name': 'Escuela Primaria 2',
        'address': 'Calle 2, Ciudad 2',
        'phone_number': '809-234-5678'
      },
    ];

    for (var school in schools) {
      await db.insert('schools', school);
    }
  }
}
