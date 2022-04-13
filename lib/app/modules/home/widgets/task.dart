import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';
import 'package:flutter_todolist/app/models/task_model.dart';
import 'package:intl/intl.dart';

class Task extends StatelessWidget {
  final TaskModel model;
  const Task({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MM/dd/y');

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue.withAlpha(30),
      ),
      child: IntrinsicHeight(
        child: ListTile(
          leading: Checkbox(
            onChanged: (value) {},
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
    );
  }
}
