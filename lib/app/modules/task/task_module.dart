import 'package:flutter_todolist/app/core/modules/todo_list_module.dart';
import 'package:flutter_todolist/app/modules/task/create_task_controller.dart';
import 'package:flutter_todolist/app/modules/task/create_task_page.dart';
import 'package:provider/provider.dart';

class TaskModule extends TodoListModule {
  TaskModule()
      : super(
          bindings: [
            ChangeNotifierProvider(
              create: (context) => CreateTaskController(),
            ),
          ],
          routers: {
            '/task/create': (context) => CreateTaskPage(
                  createTaskController: context.read(),
                ),
          },
        );
}
