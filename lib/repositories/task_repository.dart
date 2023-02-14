import 'package:sqflite/sqflite.dart' as sql;
import 'package:fodo_app/repositories/database/database_sqlite.dart';
import 'package:fodo_app/models/task.dart';

class TaskRepository {
  static Future<int> createTask(String title, String? descrption) async {
    final db = await SqliteHelper.db();

    final data = {'title': title, 'description': descrption};
    final id = await db.insert('tasks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> all() async {
    final db = await SqliteHelper.db();
    final tasksData = await db.query('tasks', orderBy: "created_at");
    return tasksData;
    // final tasks = tasksData.map((data) {
    //   if (data != null) {
    //     return Task(
    //       id: data['id'],
    //       title: data['title'],
    //       description: data['description'],
    //       state: taskStateFromNum(data['state']),
    //     );
    //   }
    // });
  }

  static Future<List<Map<String, dynamic>>> findOne(int id) async {
    final db = await SqliteHelper.db();
    return db.query('tasks', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> update(int id, String title, String? descrption) async {
    final db = await SqliteHelper.db();

    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    return await db.update('tasks', data, where: "id = ?", whereArgs: [id]);
    ;
  }

  // Delete
  static Future<void> delete(int id) async {
    final db = await SqliteHelper.db();
    try {
      await db.delete("tasks", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      // 削除時のエラーは削除が成功しているということでそのままにする
    }
  }
}
