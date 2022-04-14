import 'package:flutter_todolist/app/core/notifier/default_change_notifier.dart';
import 'package:flutter_todolist/app/models/task_filter_enum.dart';
import 'package:flutter_todolist/app/models/task_model.dart';
import 'package:flutter_todolist/app/models/total_task_model.dart';
import 'package:flutter_todolist/app/models/week_task_model.dart';
import 'package:flutter_todolist/app/services/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;

  HomeController({
    required TasksService tasksService,
  }) : _tasksService = tasksService;

  TotalTaskModel? tomorrowTotalTasks;
  TotalTaskModel? weekTotalTasks;
  TotalTaskModel? todayTotalTasks;

  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];

  var filterSelected = TaskFilterEnum.today;

  DateTime? initialDate;
  DateTime? selectedDay;

  Future<void> getAllTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek(),
    ]);

    final todayTasks = allTasks[0] as List<TaskModel>;
    final tomorrowTasks = allTasks[1] as List<TaskModel>;
    final weekTasks = allTasks[2] as WeekTaskModel;

    todayTotalTasks = TotalTaskModel(
      totalTasks: todayTasks.length,
      totalTasksFinish: todayTasks.where((task) => task.finished).length,
    );

    tomorrowTotalTasks = TotalTaskModel(
      totalTasks: tomorrowTasks.length,
      totalTasksFinish: tomorrowTasks.where((task) => task.finished).length,
    );

    weekTotalTasks = TotalTaskModel(
      totalTasks: weekTasks.tasks.length,
      totalTasksFinish: weekTasks.tasks.where((task) => task.finished).length,
    );

    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();

    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _tasksService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _tasksService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekTasks = await _tasksService.getWeek();
        initialDate = weekTasks.startDate;
        tasks = weekTasks.tasks;
        break;
    }

    allTasks = tasks;
    filteredTasks = tasks;

    if (filterSelected == TaskFilterEnum.week) {
      findByDay(initialDate!);
    }

    hideLoading();
    notifyListeners();
  }

  void findByDay(DateTime date) {
    selectedDay = date;

    filteredTasks = allTasks.where((task) => task.dateTime == date).toList();
    notifyListeners();
  }

  Future<void> refreshPage() async {
    await findTasks(filter: filterSelected);
    await getAllTasks();
    notifyListeners();
  }

  Future<void> checkOrUncheckedTask(TaskModel task) async {
    showLoadingAndResetState();
    showLoading();

    final taskUpdate = task.copyWith(finished: !task.finished);

    await _tasksService.checkOrUncheckTask(taskUpdate);

    hideLoading();
    refreshPage();
  }
}
