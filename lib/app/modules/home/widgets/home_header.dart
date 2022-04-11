import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/auth/auth_provider.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({Key? key}) : super(key: key);

  final Shader gradText = LinearGradient(colors: <Color>[
    Colors.purple,
    Colors.blue,
    Colors.blue.shade200,
  ]).createShader(
    const Rect.fromLTWH(100, 0, 200, 0),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Selector<AuthProvider, String>(
          selector: (context, authProvider) =>
              authProvider.user?.displayName ?? 'Guess',
          builder: (_, value, __) {
            return Text(
              'Hello, $value!',
              style: context.textStyle.copyWith(
                fontSize: 20,
                foreground: Paint()..shader = gradText,
              ),
            );
          },
        ),
      ],
    );
  }
}
