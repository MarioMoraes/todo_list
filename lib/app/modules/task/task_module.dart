import 'package:flutter_todolist/app/core/modules/todo_list_module.dart';
import 'package:flutter_todolist/app/modules/task/create_task_controller.dart';
import 'package:flutter_todolist/app/modules/task/create_task_page.dart';
import 'package:flutter_todolist/app/repositories/tasks/tasks_repository.dart';
import 'package:flutter_todolist/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:flutter_todolist/app/services/tasks/tasks_service.dart';
import 'package:provider/provider.dart';

import '../../services/tasks/tasks_service_impl.dart';

class TaskModule extends TodoListModule {
  TaskModule()
      : super(
          bindings: [
            Provider<TasksRepository>(
              create: (context) => TasksRepositoryImpl(
                connectionFactory: context.read(),
              ),
            ),
            Provider<TasksService>(
              create: (context) => TasksServiceImpl(
                repository: context.read(),
              ),
            ),
            ChangeNotifierProvider(
              create: (context) => CreateTaskController(
                service: context.read(),
              ),
            ),
          ],
          routers: {
            '/task/create': (context) => CreateTaskPage(
                  controller: context.read(),
                ),
          },
        );
}
