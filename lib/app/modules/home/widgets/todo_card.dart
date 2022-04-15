import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';
import 'package:flutter_todolist/app/models/task_filter_enum.dart';
import 'package:flutter_todolist/app/models/total_task_model.dart';
import 'package:flutter_todolist/app/modules/home/home_controller.dart';
import 'package:provider/provider.dart';

class TodoCard extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilterEnum;
  final TotalTaskModel? totalTaskModel;
  final bool selected;

  const TodoCard({
    Key? key,
    required this.label,
    required this.taskFilterEnum,
    required this.selected,
    this.totalTaskModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.read<HomeController>().findTasks(filter: taskFilterEnum),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 120,
          maxWidth: 150,
        ),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selected ? context.primaryColor : Colors.blue.withAlpha(50),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${totalTaskModel?.totalUnFinished ?? 0} TASKS',
              style: context.textStyle.copyWith(
                fontSize: 12,
                color: selected ? Colors.yellow : Colors.black54,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                label,
                style: context.textStyle.copyWith(
                  fontSize: 14,
                  color: selected ? Colors.white : Colors.black54,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 10,
            ),
            TweenAnimationBuilder<double>(
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  color: Colors.blue,
                  backgroundColor: Colors.white,
                );
              },
              duration: const Duration(seconds: 1),
              tween: Tween(
                begin: 0.0,
                end: _getPercentFinished(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getPercentFinished() {
    final total = totalTaskModel?.totalTasks ?? 0.0;
    final totalFinished = totalTaskModel?.totalTasksFinish ?? 0.1;

    if (total == 0) {
      return 0.0;
    }

    final percent = (totalFinished * 100) / total;
    return percent / 100;
  }
}
