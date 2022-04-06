import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';

class Task extends StatefulWidget {
  const Task({Key? key}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // boxShadow: const [BoxShadow(color: Colors.grey)],
        color: Colors.blue.withAlpha(30),
      ),
      child: IntrinsicHeight(
        child: ListTile(
          leading: Checkbox(
            onChanged: (value) {
              setState(() {
                value = true;
              });
            },
            value: false,
          ),
          title: Text(
            'Task Description',
            style:
                context.textStyle.copyWith(fontSize: 15, color: Colors.black),
          ),
          subtitle: Text(DateTime.now().toIso8601String()),
        ),
      ),
    );
  }
}
