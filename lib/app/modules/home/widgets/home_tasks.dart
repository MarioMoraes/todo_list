import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';
import 'package:flutter_todolist/app/models/task_filter_enum.dart';
import 'package:flutter_todolist/app/models/task_model.dart';
import 'package:flutter_todolist/app/modules/home/home_controller.dart';
import 'package:provider/provider.dart';

import 'task.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Selector<HomeController, String>(
            selector: (context, controller) =>
                controller.filterSelected.description,
            builder: (context, value, child) {
              return Text(
                "$value Task's",
                style: context.textStyle.copyWith(
                  fontSize: 16,
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
              children: context
                  .select<HomeController, List<TaskModel>>(
                      (controller) => controller.filteredTasks)
                  .map((e) => Task(model: e))
                  .toList())
        ],
      ),
    );
  }
}
