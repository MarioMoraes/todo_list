import 'package:flutter_todolist/app/core/database/sqlite_connection_factory.dart';
import 'package:flutter_todolist/app/models/task_model.dart';
import 'package:flutter_todolist/app/repositories/tasks/tasks_repository.dart';

class TasksRepositoryImpl extends TasksRepository {
  final SqliteConnectionFactory _connectionFactory;

  TasksRepositoryImpl({required SqliteConnectionFactory connectionFactory})
      : _connectionFactory = connectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _connectionFactory.openConnection();
    conn.insert('todo', {
      'id': null,
      'descricao': description,
      'data_hora': date.toIso8601String(),
      'finalizado': 0,
    });
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final startDate = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endDate = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final conn = await _connectionFactory.openConnection();
    final result = await conn.rawQuery('''
        select *
        from todo
        where data_hora between ? and ?
        order by data_hora
    ''', [
      startDate.toIso8601String(),
      endDate.toIso8601String(),
    ]);

    return result.map((item) => TaskModel.fromDB(item)).toList();
  }
}
