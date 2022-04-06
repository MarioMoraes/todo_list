import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/navigator/todo_list_navigator.dart';
import 'package:flutter_todolist/app/core/ui/todo_list_ui_config.dart';
import 'package:flutter_todolist/app/modules/auth/auth_module.dart';
import 'package:flutter_todolist/app/modules/home/home_module.dart';
import 'package:flutter_todolist/app/modules/splash/splash_page.dart';
import 'package:flutter_todolist/app/modules/task/task_module.dart';

class AppWidgets extends StatelessWidget {
  const AppWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: TodoListUiConfig.theme,
      navigatorKey: TodoListNavigator.navigatorKey,
      routes: {
        ...AuthModule().routers,
        ...HomeModule().routers,
        ...TaskModule().routers,
      },
      home: const SplashPage(),
    );
  }
}
