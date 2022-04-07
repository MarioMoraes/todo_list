import 'package:flutter_todolist/app/repositories/tasks/tasks_repository.dart';
import 'package:flutter_todolist/app/services/tasks/tasks_service.dart';

class TasksServiceImpl extends TasksService {
  final TasksRepository _repository;

  TasksServiceImpl({required TasksRepository repository})
      : _repository = repository;

  @override
  Future<void> save(DateTime date, String description) =>
      _repository.save(date, description);
}
