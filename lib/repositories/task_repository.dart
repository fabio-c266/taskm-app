import 'package:sqflite/sqflite.dart';
import 'package:tasksm_app/database.dart';
import 'package:tasksm_app/models/task.dart';

class TaskRepository {
  Future<Database> _getDatabaseConnection() async {
    return await Sqlite().getConnection();
  }

  Future<Task> create(String title) async {
    final db = await _getDatabaseConnection();
    await db.insert(
      'task',
      {'title': title},
    );

    final List<Map<String, dynamic>> rows = await db.query(
      'task',
      where: 'title = ?',
      whereArgs: [title],
    );

    await db.close();
    final row = rows.first;
    return Task(
        id: row['id'] as int, title: row['title'], isDone: row['isDone'] == 1);
  }

  Future<Task?> find(int id) async {
    final db = await _getDatabaseConnection();
    final List<Map<String, dynamic>> rows = await db.query(
      'task',
      where: 'id = ?',
      whereArgs: [id],
    );

    await db.close();

    if (rows.isEmpty) {
      return null;
    }

    final row = rows.first;

    return Task(
      id: row['id'] as int,
      title: row['title'] as String,
      isDone: row['isDone'] == 1,
    );
  }

  Future<void> toggleIsDone(Task task) async {
    final db = await _getDatabaseConnection();

    final int newIsDoneValue = task.isDone ? 0 : 1;

    await db.update('task', {'isDone': newIsDoneValue},
        where: 'id = ?', whereArgs: [task.id]);
    await db.close();
  }

  Future<int> findTasksDoneAmount() async {
    final db = await _getDatabaseConnection();
    int amount =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM task')) ??
            0;
    await db.close();

    return amount;
  }

  Future<List<Task>> findAllTasks() async {
    final db = await _getDatabaseConnection();
    final List<Map<String, dynamic>> rows = await db.query('task');
    await db.close();

    return rows.map((row) {
      return Task(
        id: row['id'] as int,
        title: row['title'] as String,
        isDone: row['isDone'] == 1,
      );
    }).toList();
  }

  Future<void> deleteAllTasks() async {
    final db = await _getDatabaseConnection();
    await db.execute('delete from task');

    await db.close();
  }

  Future<void> delete(Task task) async {
    final db = await _getDatabaseConnection();
    await db.delete(
      'task',
      where: 'id = ?',
      whereArgs: [task.id],
    );

    await db.close();
  }
}
