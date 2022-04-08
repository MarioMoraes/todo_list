import 'package:flutter_todolist/app/core/notifier/default_change_notifier.dart';
import 'package:flutter_todolist/app/services/tasks/tasks_service.dart';

class CreateTaskController extends DefaultChangeNotifier {
  final TasksService _service;
  DateTime? _selectedDate;

  CreateTaskController({required TasksService service}) : _service = service;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (_selectedDate != null) {
        await _service.save(_selectedDate!, description);
        success();
      } else {
        setError('Data da task não selecionada');
      }
    } catch (e, s) {
      print(e);
      print(s);
      setError('Erro ao cadastrar task');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
