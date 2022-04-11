import 'package:flutter_todolist/app/core/modules/todo_list_module.dart';
import 'package:flutter_todolist/app/modules/home/home_controller.dart';
import 'package:flutter_todolist/app/modules/home/home_page.dart';
import 'package:provider/provider.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
          routers: {
            '/home': (context) => const HomePage(),
          },
          bindings: [
            ChangeNotifierProvider(
              create: (_) => HomeController(),
            ),
          ],
        );
}
