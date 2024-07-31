import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tecnicos_minerd/seeders/schoool_seeder.dart';
import 'package:tecnicos_minerd/seeders/user_seeder.dart';
import 'package:tecnicos_minerd/seeders/director_seeder.dart';

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
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE visit_types (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE schools (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT UNIQUE,
        name TEXT,
        address TEXT,
        phone_number TEXT
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
      CREATE TABLE visits (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        director_id TEXT,
        school_code TEXT,
        visit_reason TEXT,
        photo TEXT,
        comment TEXT,
        audio TEXT,
        latitude REAL,
        longitude REAL,
        date TEXT,
        time TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE incidents (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        educational_center TEXT,
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
    await UserSeeder.seed(db);
    await VisitTypeSeeder.seed(db);
    await SchoolSeeder.seed(db);
    await DirectorSeeder.seed(db);
  }
}
