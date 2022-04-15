import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/ui/messages.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';
import 'package:flutter_todolist/app/models/task_model.dart';
import 'package:flutter_todolist/app/modules/home/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Task extends StatelessWidget {
  final TaskModel model;
  const Task({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MM/dd/y');

    return Dismissible(
      key: Key(model.id.toString()),
      background: Container(color: context.primaryColor),
      onDismissed: (direction) {
        context.read<HomeController>().deleteTask(model);
        Messages.of(context).showInfo('Task Deleted!');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.withAlpha(30),
        ),
        child: IntrinsicHeight(
          child: ListTile(
            leading: Checkbox(
              onChanged: (value) =>
                  context.read<HomeController>().checkOrUncheckedTask(model),
              value: model.finished,
            ),
            title: Text(
              model.description,
              style: context.textStyle.copyWith(
                fontSize: 15,
                color: Colors.black,
                decoration: model.finished ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              dateFormat.format(model.dateTime),
              style: context.textStyle.copyWith(
                fontSize: 15,
                color: Colors.black26,
                decoration: model.finished ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
