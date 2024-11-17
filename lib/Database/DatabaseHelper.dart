import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton pattern for DatabaseHelper
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  // Getter for database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'khedme.db'),
      onCreate: (db, version) {
        // Create the users table
        return db.execute(
          "CREATE TABLE users("
          "id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "first_name TEXT, "
          "last_name TEXT, "
          "email TEXT, "
          "phone TEXT, "
          "address TEXT, "
          "password TEXT, "
          "role TEXT)",
        );
      },
      version: 1,
    );
  }

  // Insert a user into the database
  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
