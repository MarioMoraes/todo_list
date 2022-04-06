import 'package:sqflite_common/sqlite_api.dart';

import 'migration.dart';

class MigrationV2 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('create table teste (id Integer)');
  }

  @override
  void upgrade(Batch batch) {
    batch.execute('create table teste (id Integer)');
  }
}
