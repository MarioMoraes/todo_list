import 'package:flutter/cupertino.dart';
import 'package:flutter_todolist/app/core/database/sqlite_connection_factory.dart';

class SqliteAdmConnection with WidgetsBindingObserver {
  final sqlConnectionFactory = SqliteConnectionFactory();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // sqlConnectionFactory.openConnection();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        sqlConnectionFactory.closeConnection();
        break;
    }
  }
}
