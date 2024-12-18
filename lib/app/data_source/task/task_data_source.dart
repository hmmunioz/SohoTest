import 'package:sohotest/app/entity_models/task/task_entity.dart';
import 'package:sohotest/app/enums/filter_enum.dart';
import 'package:sohotest/app/utils/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDataSource {
  final Database database;

  TaskDataSource(this.database);

  Future<void> insertTask(TaskEntity task) async {
    await database.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> getTaskCount({bool? filterByCompleted}) async {
    final db = await DatabaseHelper.instance.database;
    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (filterByCompleted != null) {
      whereClause = 'isComplete = ?';
      whereArgs.add(filterByCompleted ? 1 : 0);
    }

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM tasks ${whereClause.isNotEmpty ? 'WHERE $whereClause' : ''}',
      whereArgs,
    );

    return result.isNotEmpty ? result.first['count'] as int : 0;
  }

  Future<List<TaskEntity>> getPaginatedTasks(
      {required int page, int limit = 20, FilterEnum filter = FilterEnum.all}) async {
    final db = await DatabaseHelper.instance.database;

    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (filter == FilterEnum.completed) {
      whereClause = 'isComplete = ?';
      whereArgs.add(1);
    } else if (filter == FilterEnum.pending) {
      whereClause = 'isComplete = ?';
      whereArgs.add(0);
    }

    final result = await db.query(
      'tasks',
      where: whereClause.isNotEmpty ? whereClause : null,
      whereArgs: whereArgs,
      limit: limit,
      offset: (page - 1) * limit,
    );

    return result.map((task) => TaskEntity.fromMap(task)).toList();
  }

  Future<List<TaskEntity>> getAllTasks() async {
    final List<Map<String, dynamic>> maps = await database.query(
      'tasks',
      orderBy: 'date ASC',
    );
    return maps.map((map) => TaskEntity.fromMap(map)).toList();
  }

  Future<void> updateTask(TaskEntity task) async {
    try {
      await database.update(
        'tasks',
        task.toMap(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteTask(int taskId) async {
    await database.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }

  Future<void> clearTasks() async {
    await database.delete('tasks');
  }

  Future<TaskEntity?> getTaskById(int taskId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [taskId],
    );
    if (maps.isNotEmpty) {
      return TaskEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<void> completeOrUncompleteTask(int taskId) async {
    final task = await database.query(
      'tasks',
      columns: ['isComplete'],
      where: 'id = ?',
      whereArgs: [taskId],
    );

    if (task.isEmpty) {
      throw Exception('Task with ID $taskId not found');
    }

    final currentStatus = task.first['isComplete'] as int;
    final newStatus = currentStatus == 1 ? 0 : 1;

    await database.update(
      'tasks',
      {'isComplete': newStatus},
      where: 'id = ?',
      whereArgs: [taskId],
    );
  }
}
