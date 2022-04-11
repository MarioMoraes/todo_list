import 'package:flutter_todolist/app/core/notifier/default_change_notifier.dart';
import 'package:flutter_todolist/app/models/task_filter_enum.dart';

class HomeController extends DefaultChangeNotifier {
  var filterSelected = TaskFilterEnum.today;
}
