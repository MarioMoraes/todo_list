import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';
import 'package:flutter_todolist/app/modules/home/widgets/home_drawer.dart';
import 'package:flutter_todolist/app/modules/home/widgets/home_tasks.dart';

import '../../core/ui/todo_list_icon.dart';
import 'widgets/home_filters.dart';
import 'widgets/home_header.dart';
import 'widgets/home_week.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  _goToCreateTask(BuildContext context) {
    Navigator.of(context).pushNamed('/task/create');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: context.primaryColor),
        actions: [
          PopupMenuButton(
            icon: const Icon(
              TodoListIcon.filter,
              size: 15,
            ),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Show Tasks Completed'),
              ),
            ],
          ),
        ],
      ),
      drawer: HomeDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: context.primaryColor,
        onPressed: (() => _goToCreateTask(context)),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      HomeHeader(),
                      HomeFilters(),
                      HomeWeek(),
                      HomeTasks(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
