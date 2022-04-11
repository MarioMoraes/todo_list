import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';

class TodoListLogo extends StatelessWidget {
  TodoListLogo({Key? key}) : super(key: key);

  final Shader gradText = LinearGradient(colors: <Color>[
    Colors.purple,
    Colors.blue,
    Colors.blue.shade400,
  ]).createShader(
    const Rect.fromLTWH(100, 0, 200, 0),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 150,
          fit: BoxFit.cover,
        ),
        Text(
          'TODO LIST',
          style: context.textStyle.copyWith(
            foreground: Paint()..shader = gradText,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
