import 'package:sqflite/sqflite.dart' as sql;
import 'package:intl/intl.dart';
import 'package:fodo_app/repositories/database/database_sqlite.dart';
import 'package:fodo_app/models/task.dart';

class TaskRepository {
  ///sqliteのqueryが返すtasksテーブルのレコードデータをTaskに変換して返す
  static Task _queryResultToTask(Map<String, dynamic> data) {
    return Task(
        id: data['id'] as int,
        title: data['title'] as String,
        description: data['description'] as String,
        state: taskStateFromNumber(data['state'] as int),
        createdAt: DateFormat('yyyy/MM/dd')
            .format(DateTime.parse(data["created_at"]).toLocal()));
  }

  static Future<Task> createTask({
    required String title,
    required String descrption,
  }) async {
    final db = await SqliteHelper.db();

    final stateNum = taskStateNumberFromState(TaskState.todo);
    final now = DateTime.now();
    final data = {
      'title': title,
      'description': descrption,
      'state': stateNum,
      'created_at': now.toString(),
      'updated_at': now.toString(),
    };
    final id = await db.insert('tasks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return Task(
        id: id,
        title: title,
        description: descrption,
        state: TaskState.todo,
        createdAt: DateFormat('yyyy/MM/dd').format(now.toLocal()));
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

  static Future<int> update(
      {required int id,
      required String title,
      required TaskState state}) async {
    final db = await SqliteHelper.db();

    final data = {
      'title': title,
      'state': taskStateNumberFromState(state),
      'updated_at': DateTime.now().toString()
    };

    return await db.update('tasks', data, where: "id = ?", whereArgs: [id]);
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
