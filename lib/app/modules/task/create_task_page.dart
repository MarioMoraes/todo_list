import 'package:flutter/material.dart';
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
      body: Container(),
    );
  }
}
