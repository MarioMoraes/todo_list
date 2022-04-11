import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_todolist/app/core/notifier/default_listener_notifier.dart';
import 'package:flutter_todolist/app/core/ui/messages.dart';
import 'package:flutter_todolist/app/core/ui/todo_list_icon.dart';
import 'package:flutter_todolist/app/core/widgets/custom_formfield.dart';
import 'package:flutter_todolist/app/core/widgets/todo_list_logo.dart';
import 'package:flutter_todolist/app/modules/auth/login/login_controller.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  final _emailFN = FocusNode();

  @override
  void initState() {
    super.initState();

    DefaultListenerNotifier(
      changeNotifier: context.read<LoginController>(),
    ).listener(
        context: context,
        successCallback: (notifier, listenerInstance) {
          listenerInstance.dispose();
          // Done
        },
        everCallBack: (notifier, listenerInstance) {
          if (notifier is LoginController) {
            if (notifier.hasInfo) {
              Messages.of(context).showInfo(notifier.infoMessage);
            }
          }
        });
  }

  @override
  void dispose() {
    super.dispose();

    _emailEC.dispose();
    _passwordEC.dispose();
    _emailFN.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LoginController>;
    return Scaffold(
      body: LayoutBuilder(
        builder: ((context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * .5,
                      child: FittedBox(
                        child: TodoListLogo(),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomFormField(
                              hint: 'Email',
                              focus: _emailFN,
                              controller: _emailEC,
                              validator: Validatorless.multiple(
                                [
                                  Validatorless.email('Email Invalid'),
                                  Validatorless.required('Email Is Required'),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomFormField(
                              hint: 'Password',
                              controller: _passwordEC,
                              validator: Validatorless.multiple(
                                [
                                  Validatorless.min(
                                      6, 'Mininum 6 Digits For Password'),
                                  Validatorless.required(
                                      'Password Is Required'),
                                ],
                              ),
                              suffixIcon: TodoListIcon.eye,
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: const Text('Forgot Password?'),
                                  onPressed: () {
                                    if (_emailEC.text.isNotEmpty) {
                                      context
                                          .read<LoginController>()
                                          .forgot(_emailEC.text);
                                    } else {
                                      Messages.of(context)
                                          .showInfo('Email is Empty!');
                                      _emailFN.requestFocus();
                                    }
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    final formValid =
                                        _formKey.currentState?.validate() ??
                                            false;
                                    if (formValid) {
                                      context.read<LoginController>().login(
                                            _emailEC.text,
                                            _passwordEC.text,
                                          );
                                    }
                                  },
                                  child: const Text('Login'),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 8,
                                    minimumSize: const Size(100, 45),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffF0F3F7),
                          border: Border(
                            top: BorderSide(
                              width: 2,
                              color: Colors.grey.withAlpha(50),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            SignInButton(
                              Buttons.Google,
                              onPressed: () {
                                context.read<LoginController>().googleLogin();
                              },
                              text: 'Continue With Google',
                              padding: const EdgeInsets.all(5),
                              shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don´t Have Account ??'),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/register');
                                  },
                                  child: const Text('Sign Up'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
