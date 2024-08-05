import 'package:sqflite/sqflite.dart';

class DirectorSeeder {
  static Future<void> seed(Database db) async {
    List<Map<String, dynamic>> directors = [
      {
        'identification': '01',
        'photo': 'https://example.com/photo1.jpg',
        'first_name': 'Juan',
        'last_name': 'Pérez',
        'birth_date': '1980/01/01',
        'address': 'Avenida 1, Ciudad 1',
        'phone_number': '809-345-6789',
      },
      {
        'identification': '02',
        'photo': 'https://example.com/photo2.jpg',
        'first_name': 'Ana',
        'last_name': 'Gómez',
        'birth_date': '1985/02/14',
        'address': 'Avenida 2, Ciudad 2',
        'phone_number': '809-456-7890',
      },
    ];

    for (var director in directors) {
      await db.insert('directors', director);
    }
  }
}
