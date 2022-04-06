import 'package:flutter/material.dart';
import 'package:flutter_todolist/app/core/auth/auth_provider.dart';
import 'package:flutter_todolist/app/core/ui/theme_extensions.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

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
                color: Colors.black,
                fontSize: 20,
              ),
            );
          },
        ),
      ],
    );
  }
}
