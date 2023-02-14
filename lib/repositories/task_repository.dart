import 'package:sqflite/sqflite.dart' as sql;
import 'package:fodo_app/repositories/database/database_sqlite.dart';
import 'package:fodo_app/models/task.dart';

class TaskRepository {
  ///sqliteのqueryが返すtasksテーブルのレコードデータをTaskに変換して返す
  static Task _queryResultToTask(Map<String, Object?> data) {
    return Task(
      id: data['id'] as int,
      title: data['title'] as String,
      description: data['description'] as String,
      state: taskStateFromNum(data['state'] as int),
    );
  }

  static Future<Task> createTask({
    required String title,
    required String descrption,
  }) async {
    final db = await SqliteHelper.db();

    final stateNum = taskStateNumFrom(TaskState.todo);
    final data = {'title': title, 'description': descrption, 'state': stateNum};
    final id = await db.insert('tasks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return Task(
        id: id, title: title, description: descrption, state: TaskState.todo);
  }

  static Future<List<Task>> all() async {
    final db = await SqliteHelper.db();
    final tasksData = await db.query('tasks', orderBy: "created_at");
    return tasksData.map(_queryResultToTask).toList();
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
