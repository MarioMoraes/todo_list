import 'package:flutter_todolist/app/models/task_model.dart';
import 'package:flutter_todolist/app/models/week_task_model.dart';
import 'package:flutter_todolist/app/repositories/tasks/tasks_repository.dart';
import 'package:flutter_todolist/app/services/tasks/tasks_service.dart';

class TasksServiceImpl extends TasksService {
  final TasksRepository _repository;

  TasksServiceImpl({required TasksRepository repository})
      : _repository = repository;

  @override
  Future<void> save(DateTime date, String description) =>
      _repository.save(date, description);

  @override
  Future<List<TaskModel>> getToday() {
    return _repository.findByPeriod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    final dateTomorrow = DateTime.now().add(const Duration(days: 1));
    return _repository.findByPeriod(dateTomorrow, dateTomorrow);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();

    var startFilter = DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endFilter;

    if (startFilter.weekday != DateTime.monday) {
      startFilter =
          startFilter.subtract(Duration(days: (startFilter.weekday - 1)));
    }
    endFilter = startFilter.add(const Duration(days: 7));
    final tasks = await _repository.findByPeriod(startFilter, endFilter);

    return WeekTaskModel(
      startDate: startFilter,
      endDate: endFilter,
      tasks: tasks,
    );
  }

  @override
  Future<void> checkOrUncheckTask(TaskModel task) =>
      _repository.checkOrUncheckTask(task);

  @override
  Future<void> deleteTask(TaskModel task) => _repository.deleteTask(task);
}
