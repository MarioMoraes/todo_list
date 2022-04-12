import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';
import 'package:flutter_todolist/app/models/task_filter_enum.dart';
import 'package:flutter_todolist/app/models/total_task_model.dart';
import 'package:flutter_todolist/app/modules/home/home_controller.dart';
import 'package:flutter_todolist/app/modules/home/widgets/todo_card.dart';
import 'package:provider/provider.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          'Filters',
          style: context.textStyle.copyWith(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TodoCard(
                    label: 'TODAY',
                    taskFilterEnum: TaskFilterEnum.today,
                    totalTaskModel:
                        context.select<HomeController, TotalTaskModel?>(
                            (task) => task.todayTotalTasks),
                    selected: context.select<HomeController, TaskFilterEnum>(
                            (value) => value.filterSelected) ==
                        TaskFilterEnum.today,
                  ),
                  TodoCard(
                    label: 'TOMORROW',
                    taskFilterEnum: TaskFilterEnum.today,
                    totalTaskModel:
                        context.select<HomeController, TotalTaskModel?>(
                            (task) => task.tomorrowTotalTasks),
                    selected: context.select<HomeController, TaskFilterEnum>(
                            (value) => value.filterSelected) ==
                        TaskFilterEnum.tomorrow,
                  ),
                  TodoCard(
                    label: 'WEEK',
                    taskFilterEnum: TaskFilterEnum.week,
                    totalTaskModel:
                        context.select<HomeController, TotalTaskModel?>(
                            (task) => task.weekTotalTasks),
                    selected: context.select<HomeController, TaskFilterEnum>(
                            (value) => value.filterSelected) ==
                        TaskFilterEnum.week,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
