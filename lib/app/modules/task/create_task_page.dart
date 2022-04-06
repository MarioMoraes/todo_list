import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';
import 'package:flutter_todolist/app/core/widgets/custom_formfield.dart';
import 'package:flutter_todolist/app/modules/task/create_task_controller.dart';

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
      body: Column(
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
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Form(
              child: CustomFormField(hint: 'Description'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.date_range,
                    color: context.primaryColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'SELECT DATE',
                    style: context.textStyle.copyWith(fontSize: 14),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
