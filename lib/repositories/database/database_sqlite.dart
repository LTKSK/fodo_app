import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SqliteHelper {
  static Database? _database;

  static Future<Database> db() async {
    if (_database != null) return _database!;

    // DBがなかったら作る
    _database = await _initDatabase();
    return _database!;
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        state int NOT NULL DEFAULT 0,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> _initDatabase() async {
    // @see https://zenn.dev/beeeyan/articles/b9f1b42de9cb67
    final dbFolder = await getApplicationSupportDirectory();
    return sql.openDatabase(
      join(dbFolder.path, 'fodo_app.db'),
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }
}
