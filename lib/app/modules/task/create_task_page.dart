import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';
import 'package:flutter_todolist/app/core/widgets/custom_formfield.dart';
import 'package:flutter_todolist/app/modules/task/create_task_controller.dart';
import 'package:flutter_todolist/app/modules/task/widgets/calendar_button.dart';

class CreateTaskPage extends StatelessWidget {
  final CreateTaskController _createTaskController;

  const CreateTaskPage({
    Key? key,
    required CreateTaskController createTaskController,
  })  : _createTaskController = createTaskController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.primaryColor,
        icon: const Icon(Icons.save),
        onPressed: () {},
        label: const Text('Save Task'),
      ),
      body: Form(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'New Task',
                  style: context.textStyle.copyWith(
                    color: context.primaryColor,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomFormField(hint: 'Description'),
              const SizedBox(
                height: 10,
              ),
              const Align(
                  alignment: Alignment.centerLeft, child: CalendarButton())
            ],
          ),
        ),
      ),
    );
  }
}
