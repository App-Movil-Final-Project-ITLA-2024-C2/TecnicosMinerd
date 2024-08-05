import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../seeders/director_seeder.dart';
import '../seeders/visittype_seeder.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'minerd_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE visit_types (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE directors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        identification TEXT UNIQUE,
        photo TEXT,
        first_name TEXT,
        last_name TEXT,
        birth_date TEXT,
        address TEXT,
        phone_number TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE incidents (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        schoolName TEXT,
        regional TEXT,
        district TEXT,
        date TEXT,
        description TEXT,
        photo TEXT,
        audio TEXT
      )
    ''');

    await _seedDatabase(db);
  }

  Future<void> _seedDatabase(Database db) async {
    await VisitTypeSeeder.seed(db);
    await DirectorSeeder.seed(db);
  }
}
