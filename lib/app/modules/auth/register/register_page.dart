import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';
import 'package:flutter_todolist/app/core/ui/todo_list_icon.dart';
import 'package:flutter_todolist/app/core/widgets/custom_formfield.dart';
import 'package:flutter_todolist/app/core/widgets/todo_list_logo.dart';
import 'package:flutter_todolist/app/modules/auth/register/register_controller.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/notifier/default_listener_notifier.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _retypeEC = TextEditingController();

  @override
  void initState() {
    super.initState();

    final defaultListener = DefaultListenerNotifier(
      changeNotifier: context.read<RegisterController>(),
    );

    defaultListener.listener(
      context: context,
      successCallback: (notifier, listenerInstance) {
        listenerInstance.dispose();
      },
      // errorCallback: (notifier, listenerInstance) => print('Esse Tramento É Opcional!'),
    );
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    _retypeEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey.shade50,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: ClipOval(
              child: Container(
                color: context.primaryColor.withAlpha(20),
                padding: const EdgeInsets.all(10),
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                  color: context.primaryColor,
                ),
              ),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 20, color: context.primaryColor),
              ),
            ],
          )),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * .5,
            child: FittedBox(
              child: TodoListLogo(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  CustomFormField(
                    hint: 'Email',
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Email Is Required'),
                      Validatorless.email('Email Is Invalid'),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    hint: 'Password',
                    obscureText: true,
                    suffixIcon: TodoListIcon.eye,
                    controller: _passwordEC,
                    validator: Validatorless.multiple([
                      Validatorless.min(6, 'Minimum 6 Digits For Password'),
                      Validatorless.required('Password Is Required'),
                    ]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                      hint: 'ReType Password',
                      obscureText: true,
                      suffixIcon: TodoListIcon.eye,
                      controller: _retypeEC,
                      validator: Validatorless.multiple([
                        Validatorless.min(6, 'Minimum 6 Digits For Password'),
                        Validatorless.required('Retype Is Required'),
                        Validatorless.compare(
                            _passwordEC, 'Password Do Not Equal'),
                      ])),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        final formValid =
                            formKey.currentState?.validate() ?? false;

                        if (formValid) {
                          context
                              .read<RegisterController>()
                              .registerUser(_emailEC.text, _passwordEC.text);
                        }
                      },
                      child: const Text('Create Account'),
                      style: ElevatedButton.styleFrom(
                        elevation: 8,
                        minimumSize: const Size(100, 45),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
