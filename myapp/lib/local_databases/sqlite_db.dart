import 'package:myapp/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteDatabase {
  static SQLiteDatabase _instance = SQLiteDatabase();
  static SQLiteDatabase get sharedInstance =>
      _instance ?? SQLiteDatabase();

  final TABLE_USER = 'User';
  Future<Database> getDatabase() async {
    final databasePath = await getDatabasesPath();
    return await openDatabase(
      join(databasePath, 'cecomtech_db.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $TABLE_USER(id INTEGER PRIMARY KEY, email TEXT, tokenKey TEXT)',
        );
      },
      version: 1,
    );
  }
  Future<void> updateUser({User user}) async {
    final db = await this.getDatabase();
    await db.update(
      TABLE_USER,
      user.toMap,
      where: "id = ?",
      whereArgs: [user.id],
    );
  }
  Future<void> deleteUser({User user}) async {
    final db = await this.getDatabase();
    await db.delete(
      TABLE_USER,
      where: "id = ?",
      whereArgs: [user.id],
    );
  }
  Future<void> insertUser({User user}) async {
    final db = await this.getDatabase();
    await db.insert(
      TABLE_USER,
      user.toMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<User> getUser() async {
    final db = await this.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(TABLE_USER);
    return User.fromJSON(data: maps[0] as Map<String, dynamic>);
  }

}