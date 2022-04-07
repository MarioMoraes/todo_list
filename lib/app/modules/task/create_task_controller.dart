import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/services/tasks/tasks_service.dart';

class CreateTaskController extends ChangeNotifier {
  final TasksService _service;
  DateTime? _selectedDate;

  CreateTaskController({required TasksService service}) : _service = service;

  set selectedDate(DateTime? selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;
}
