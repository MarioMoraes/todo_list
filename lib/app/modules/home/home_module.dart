import 'package:flutter_todolist/app/core/modules/todo_list_module.dart';
import 'package:flutter_todolist/app/modules/home/home_page.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          routers: {
            '/home': (context) => const HomePage(),
          },
          // bindings: [],
        );
}
