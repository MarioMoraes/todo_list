import 'package:flutter/material.dart';

class TodoListUiConfig {
  TodoListUiConfig._();

  static ThemeData get theme => ThemeData(
        primaryColor: const Color(0xff5c77ce),
        primaryColorLight: const Color(0xffABC8f7),
        fontFamily: 'Lexend',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff5c77ce),
          ),
        ),
      );
}
