import 'package:sqflite_common/sqlite_api.dart';

import 'migration.dart';

class MigrationV3 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('create table teste2 (id Integer)');
  }

  @override
  void upgrade(Batch batch) {
    batch.execute('create table teste2 (id Integer)');
  }
}
