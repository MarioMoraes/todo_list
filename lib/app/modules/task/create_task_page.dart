import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/notifier/default_listener_notifier.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';
import 'package:flutter_todolist/app/core/widgets/custom_formfield.dart';
import 'package:flutter_todolist/app/modules/task/create_task_controller.dart';
import 'package:flutter_todolist/app/modules/task/widgets/calendar_button.dart';
import 'package:validatorless/validatorless.dart';

class CreateTaskPage extends StatefulWidget {
  final CreateTaskController _controller;

  const CreateTaskPage({Key? key, required CreateTaskController controller})
      : _controller = controller,
        super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionEC = TextEditingController();

  @override
  void initState() {
    super.initState();

    DefaultListenerNotifier(changeNotifier: widget._controller).listener(
      context: context,
      successCallback: (notifier, listenerInstance) {
        print('Estou aqui');
        listenerInstance.dispose();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void dispose() {
    _descriptionEC.dispose();
    super.dispose();
  }

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
            icon: Icon(
              Icons.close,
              color: context.primaryColor,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: context.primaryColor,
        icon: const Icon(Icons.save),
        onPressed: () {
          final formValid = _formKey.currentState?.validate() ?? false;

          if (formValid) {
            widget._controller.save(_descriptionEC.text);
          }
        },
        label: const Text('Save Task'),
      ),
      body: Form(
        key: _formKey,
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
              CustomFormField(
                hint: '',
                controller: _descriptionEC,
                validator: Validatorless.required('Description Is Required!'),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CalendarButton(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
